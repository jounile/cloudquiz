# Cloud Quiz

## Intro



### Backend

#### Install tools

```
npm install
```

https://serverless.com



#### Deploy functions

##### ARM Template

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fjounile%2Fcloudquiz%2Fblob%2Fmaster%2Fazuredeploy.json" target="_blank">![Deploy to Azure](http://azuredeploy.net/deploybutton.png)</a>

Connect to Azure
```
az login
```

Deploy resources
```
./deploy.sh
```

Clean up
```
./undeploy.sh
```

<!--
##### Serverless template

```
serverless deploy
```
-->
Test function

```
curl -X POST https://cloudquiz-fa.azurewebsites.net/api/answer -H "Content-Type: application/json" -d '{ "id":"4444", "name":"jouni" }' 
```
<!--
or
```
serverless invoke -f answer --path data.json
```
-->

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
