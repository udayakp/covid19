require('dotenv').config({silent: true})

const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const assistant = require('./assistant.js');
const cloudant = require('./cloudant.js');
const uuidv4 = require('uuid/v4');

var router = express.Router();
var multer = require('multer');
var upload = multer();
var session = require('express-session');
var cookieParser = require('cookie-parser');
// UUID creation
var secretkey = uuidv4();

router.use(bodyParser.json());
router.use(bodyParser.urlencoded({ extended: true })); 
router.use(upload.array());
router.use(cookieParser());
router.use(session({secret: secretkey}));

router.post('/register', (req,res) => {
  if (!req.body.username || !req.body.password){
    res.status("400");
    res.send("Invalid details! Please check if you're giving username and password");
  } else {
    username = req.body.username;
    password = req.body.password;
    email = req.body.email;
    
    cloudant
    .createUser(username, password, email)
    .then(data => {
      if (data.statusCode != 201) {
        console.log(data.statusCode);
        res.sendStatus(data.statusCode)
      } else {
        console.log(data);
        res.send(data);
      }
    }).catch(err => handleError(res, err));
  }
});

router.post('/login', (req,res) => {
  const username = req.body.username;
  const password = req.body.password;
  
  console.log(username, password);
  
  cloudant
  .findUser(username, password)
  .then(data => {
    if (data.statusCode == 200) {
      req.sendStatus(data.statusCode);
      req.send(data);
    } else{
      res.send(data);
    }
  })
  .catch(err => handleError(res, err));
});

router.get('/users', function(req,res){
  cloudant.listUsers()
  .then(data => {
    res.send(data);
  })
})

const handleError = (res, err) => {
  const status = err.code !== undefined && err.code > 0 ? err.code : 500;
  return res.status(status).json(err);
};

module.exports = router;