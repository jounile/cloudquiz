<template>
  <div id="app">
    <h1>{{ title }}</h1>

    <ul>
      <li>
        <a href="https://vuejs.org" target="_blank">
          <img src="./assets/vue-logo.png" width="" height="50">
        </a>
      </li>
      <li>
        <a href="https://serverless.com" target="_blank">
          <img src="./assets/serverless-logo.png" width="200" height="">
        </a>
      </li>
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
      msg: 'A Serverless Vue.js App'
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