// handler.js

'use strict';

/* eslint-disable no-param-reassign */

module.exports.hello = function (context, req) {
  
  context.log("Request Headers = " + JSON.stringify(req.headers));

  const query = req.query; // dictionary of query strings
  const body = req.body; // Parsed body based on content-type
  const method = req.method; // HTTP Method (GET, POST, PUT, etc.)
  const originalUrl = req.originalUrl; // Original URL of the request - https://myapp.azurewebsites.net/api/foo?code=sc8Rj2a7J
  const headers = req.headers; // dictionary of headers
  const params = req.params; // dictionary of params from URL
  const rawBody = req.rawBody; // unparsed body

  if (req.query.name || (req.body && req.body.name)) {
 
    if (req.body && req.body.name) {
      context.log("Request Query Id = " + req.query.id);
      context.log("Request Query Name = " + req.query.name);
      context.bindings.record = {
        id: req.body.id,
        name: req.body.name
      }
    }

    if (req.query.name){
          
      context.log("Request Body Id = " + req.query.id);
      context.log("Request Body Name = " + req.query.name);
      context.bindings.record = {
        id: req.query.id,
        name: req.query.name
      }
    }

    context.res = {
      status: 200, /* Defaults to 200 */
      body: "Hello " + (req.query.name || req.body.name)
    };

  } else {
    context.res = {
      status: 400,
      body: "Please pass a name on the query string or in the request body"
    };
  }
  
  context.done();
};