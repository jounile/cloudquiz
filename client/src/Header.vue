<template>
<div id="header">

  <router-link to="/" exact>Home</router-link>
  <router-link to="/answer" exact>Give your answer</router-link>
  <router-link to="/answers" exact>List answers</router-link>

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

</div>
</template>

<script>

export default {
  name: 'header',
  data() {
    return {
      title: 'Cloud Quiz',
      msg: 'A Serverless Vue.js App'
    }
  }
}
</script>


<style scoped>
.router-link-active {
  color: red;
}
</style>