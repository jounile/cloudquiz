import Vue from 'vue'
import VueRouter from 'vue-router'
import App from './App.vue'
import Answer from './Answer.vue'
import Home from './Home.vue'

Vue.use(VueRouter);

const routes = [
	{ path: '/', component: Home },
	{ path: '/answer', component: Answer }
];

const router = new VueRouter({
	routes,
	mode: 'history'
});

new Vue({
  el: '#app',
  router,
  render: h => h(App)
});
