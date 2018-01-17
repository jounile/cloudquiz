# Cloud Quiz

## Intro



### Backend

#### Install tools

Serverless

```
npm install serverless -g
```

https://serverless.com



#### Deploy backend

Deploy backend (API, Functions & Database)

```
serverless deploy
```

Deploy only the lambda function

```
sls deploy function -f hello
```

Test function

```
curl -X POST https://cloudquiz.azurewebsites.net/api/hello -H "Content-Type: application/json" -d '{ "id":"4444", "name":"jouni" }' 
```
or
```
serverless invoke -f hello --path data.json
```

### Frontend

#### Install tools

```
npm install -g vue-cli

vue init webpack-simple myservice

cd myservice

npm install
```

#### Run locally

```
npm run dev
```

#### Build distribution

```
npm run build
```

#### Deploy frontend

```
sls client deploy
```



## Author

[Jouni Leino](https://github.com/jounile)