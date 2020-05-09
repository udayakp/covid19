require('dotenv').config({silent: true})

const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const assistant = require('./assistant.js');
const cloudant = require('./cloudant.js');
var router = express.Router();
var multer = require('multer');
var upload = multer();
var session = require('express-session');
var cookieParser = require('cookie-parser');
router.use(bodyParser.json());
router.use(bodyParser.urlencoded({ extended: true })); 
router.use(upload.array());
router.use(cookieParser());
// UUID creation
const uuidv4 = require('uuid/v4');
var secretkey = uuidv4();
router.use(session({secret: secretkey}));

router.post('/register', (req,res) => {
    if (!req.body.userID || !req.body.pass){
      res.status("400");
      res.send("Invalid details!");
    } else {
      Users.filter(function(user){
        if(user.id === req.body.id){
            res.render('register', {
              message: "User Already Exists! Login or choose another user id"});
        }
      });
    cloudant
      .createuser(userID, name, pass, email)
      .then(data => {
        if (data.statusCode != 201) {
            console.log(data.statusCode);
          res.sendStatus(data.statusCode)
        } else {
            console.log(data);
          //res.send(data.data)
          res.render('register', {
            message: "DB Issue! Login or choose another user id"});
        }
      })
      .catch(err => handleError(res, err));
    }
});


router.post('login', (req,res) => {
    const userID = req.body.userId;
    const pass = req.body.pass;
    console.log(userID,pass);
  
    cloudant
      .finduser(userID, pass)
      .then(data => {
        if (data.statusCode != 201) {
          if(data.userID == userID && data.pass == pass){
            req.session.user = userID;
            console.log(req.body);
            console.log(data);
            console.log(cloudant.userlist());
            console.log(data.statusCode);
          res.sendStatus(data.statusCode)
          }
          else{
            res.send("Not Auth")  
          }          
        } else {
          res.send(data.data)
        }
      })
      .catch(err => handleError(res, err));
});

router.get('/users', function(req,res){
    cloudant.userlist()
    .then(data => {
        res.send(data);
    })
})

const handleError = (res, err) => {
    const status = err.code !== undefined && err.code > 0 ? err.code : 500;
    return res.status(status).json(err);
  };


module.exports = router;