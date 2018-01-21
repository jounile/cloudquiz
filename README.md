# Cloud Quiz

## Intro



### Backend

#### Install tools

```
npm install
```

https://serverless.com



#### Deploy functions

```
serverless deploy
```

Test function

```
curl -X POST https://cloudquiz.azurewebsites.net/api/answer -H "Content-Type: application/json" -d '{ "id":"4444", "name":"jouni" }' 
```
or
```
serverless invoke -f answer --path data.json
```

### Frontend

#### Install tools

```
cd cloudquiz

npm install
```
This will install packages vue, vue-router, axios

#### Run locally

```
npm run dev
```

#### Build distribution

```
npm run build
```





## Author

[Jouni Leino](https://github.com/jounile)