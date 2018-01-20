<template>
  <div id="app">
    <img src="./assets/serverless-logo.png" width="400" height="">
    <img src="./assets/vue-logo.png" >

    <h1>{{ title }}</h1>
    <h2>{{ msg }}</h2>
    <ul>
      <li><a href="https://vuejs.org" target="_blank">vuejs.org</a></li>
      <li><a href="https://serverless.com" target="_blank">serverless.com</a></li>
      <li><a href="https://github.com/fernando-mc/serverless-finch" target="_blank">Finch plugin</a></li>
    </ul>

  	<router-view></router-view>

    
  </div>
</template>


<script>
export default {
  name: 'app',
  data() {
    return {
      title: 'Cloud Quiz',
      msg: 'Serverless Vue.js App'
    }
  }
}
</script>


<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

h1, h2 {
  font-weight: normal;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: #42b983;
}
</style>