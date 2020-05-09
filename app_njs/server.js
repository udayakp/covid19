require('dotenv').config({silent: true})

const express = require('express');
const bodyParser = require('body-parser');

const assistant = require('./lib/assistant.js');
const port = process.env.PORT || 3000

const cloudant = require('./lib/cloudant.js');

const app = express();
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
//url=require("url")

var router = express.Router();

app.get('/', (req, res) => {
  //console.log(req)
  console.log(res.body);
  return res.json({
  status: 'ok'
});
});

authrouter = require('./lib/authroutes.js');

app.use('/api/',authrouter);


const handleError = (res, err) => {
  const status = err.code !== undefined && err.code > 0 ? err.code : 500;
  return res.status(status).json(err);
};



const server = app.listen(port, () => {
   const host = server.address().address;
   const port = server.address().port;
   console.log(`SolutionStarterKitCooperationServer listening at http://${host}:${port}`);
});
