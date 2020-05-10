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



router.post('/api/message', (req, res) => {
const text = req.body.text || '';
const sessionid = req.body.sessionid;
//const sessionid = assistant.session();
console.log(req.body);
assistant
    .message(text, sessionid)
    .then(result => {
    return post_process_assistant(result)
    //return result
    })
    .then(new_result => {
    res.json(new_result)
    })
    .catch(err => handleError(res, err));
});


function post_process_assistant(result) {
let resource
// First we look to see if a) Watson did identify an intent (as opposed to not
// understanding it at all), and if it did, then b) see if it matched a supplies entity
// with reasonable confidence. "supplies" is the term our trained Watson skill uses
// to identify the target of a question about resources, i.e.:
//
// "Where can i find face-masks?"
//
// ....should return with an enitity == "supplies" and entitty.value = "face-masks"
//
// That's our trigger to do a lookup - using the entitty.value as the name of resource
// to to a datbase lookup.
if (result.intents.length > 0 ) {
    result.entities.forEach(item => {
    if ((item.entity == "supplies") &&  (item.confidence > 0.3)) {
        resource = item.value
    }
    })
}
if (!resource) {
    return Promise.resolve(result)
} else {
    // OK, we have a resource...let's look this up in the DB and see if anyone has any.
    return cloudant
    .find('', resource, '')
    .then(data => {
        let processed_result = result
        if ((data.statusCode == 200) && (data.data != "[]")) {
        processed_result["resources"] = JSON.parse(data.data)
        processed_result["generic"][0]["text"] = 'There is' + '\xa0' + resource + " available"
        } else {
        processed_result["generic"][0]["text"] = "Sorry, no" + '\xa0' + resource + " available"           
        }
        return processed_result
    })
}
}


const handleError = (res, err) => {
  const status = err.code !== undefined && err.code > 0 ? err.code : 500;
  return res.status(status).json(err);
};

module.exports = router;