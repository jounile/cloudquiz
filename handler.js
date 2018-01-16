// handler.js

'use strict';

/* eslint-disable no-param-reassign */

module.exports.hello = function (context, req) {
  
  context.log("Request Headers = " + JSON.stringify(req.headers));
  context.log("Request Body = " + JSON.stringify(req.body));

  const query = req.query; // dictionary of query strings
  const body = req.body; // Parsed body based on content-type
  const method = req.method; // HTTP Method (GET, POST, PUT, etc.)
  const originalUrl = req.originalUrl; // Original URL of the request - https://myapp.azurewebsites.net/api/foo?code=sc8Rj2a7J
  const headers = req.headers; // dictionary of headers
  const params = req.params; // dictionary of params from URL
  const rawBody = req.rawBody; // unparsed body

  context.bindings.record = {
      id: req.body.id,
      name: req.body.name
  }

  context.done();
};