# Cloud Quiz

## Intro



### Backend

#### Install tools

Serverless

npm install serverless -g

https://serverless.com


Finch plugin - For AWS S3 static website deployment

npm install --save serverless-finch

https://www.npmjs.com/package/serverless-finch


#### Deploy backend

Deploy backend (API, Functions & Database)

sls deploy

Deploy only the lambda function

serverless deploy function -f myservice





### Frontend

#### Install tools

npm install -g vue-cli

vue init webpack-simple myservice

cd myservice

npm install

#### Run locally

npm run dev

#### Build distribution

npm run build

#### Deploy frontend

sls client deploy