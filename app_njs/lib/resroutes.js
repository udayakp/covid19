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


/**
 * Get a list of resources
 *
 * The query string may contain the following qualifiers:
 * 
 * - type
 * - name
 * - userID
 *
 * A list of resource objects will be returned (which can be an empty list)
 */
app.get('/api/resource', (req, res) => {
    const type = req.query.type;
    const name = req.query.name;
    const userID = req.query.userID;
    cloudant
      .find(type, name, userID)
      .then(data => {
        if (data.statusCode != 200) {
          res.sendStatus(data.statusCode)
        } else {
          res.send(data.data)
        }
      })
      .catch(err => handleError(res, err));
  });
  
  /**
   * Create a new resource
   *
   * The body must contain:
   * 
   * - type
   * - name
   * - contact
   * - userID
   *
   * The body may also contain:
   * 
   * - description
   * - quantity (which will default to 1 if not included)
   * 
   * The ID and rev of the resource will be returned if successful
   */
  let types = ["Food", "Other", "Help"]
  app.post('/api/resource', (req, res) => {
    if (!req.body.type) {
      return res.status(422).json({ errors: "Type of item must be provided"});
    }
    if (!types.includes(req.body.type)) {
      return res.status(422).json({ errors: "Type of item must be one of " + types.toString()});
    }
    if (!req.body.name) {
      return res.status(422).json({ errors: "Name of item must be provided"});
    }
    if (!req.body.contact) {
      return res.status(422).json({ errors: "A method of conact must be provided"});
    }
    const type = req.body.type;
    const name = req.body.name;
    const description = req.body.description || '';
    const userID = req.body.userID || '';
    const quantity = req.body.quantity || 1;
    const location = req.body.location || '';
    const contact = req.body.contact;
  
    cloudant
      .create(type, name, description, quantity, location, contact, userID)
      .then(data => {
        if (data.statusCode != 201) {
          res.sendStatus(data.statusCode)
        } else {
          res.send(data.data)
        }
      })
      .catch(err => handleError(res, err));
  });
  
  /**
   * Update new resource
   *
   * The body may contain any of the valid attributes, with their new values. Attributes
   * not included will be left unmodified.
   * 
   * The new rev of the resource will be returned if successful
   */
  
  app.patch('/api/resource/:id', (req, res) => {
    const type = req.body.type || '';
    const name = req.body.name || '';
    const description = req.body.description || '';
    const userID = req.body.userID || '';
    const quantity = req.body.quantity || '';
    const location = req.body.location || '';
    const contact = req.body.contact || '';
  
    cloudant
      .update(req.params.id, type, name, description, quantity, location, contact, userID)
      .then(data => {
        if (data.statusCode != 200) {
          res.sendStatus(data.statusCode)
        } else {
          res.send(data.data)
        }
      })
      .catch(err => handleError(res, err));
  });
  
  /**
   * Delete a resource
   */
  app.delete('/api/resource/:id', (req, res) => {
    cloudant
      .deleteById(req.params.id)
      .then(statusCode => res.sendStatus(statusCode))
      .catch(err => handleError(res, err));
  });

const handleError = (res, err) => {
const status = err.code !== undefined && err.code > 0 ? err.code : 500;
return res.status(status).json(err);
};

module.exports = router;  