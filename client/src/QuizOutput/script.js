import bus from '../bus'
import Vue from 'vue'
import axios from 'axios'

Vue.prototype.$http = axios

import AnswerData from '../AnswerData/index.vue'
//import GithubUserData from '../GithubUserData/index.vue'

export default {
  name: 'QuizOutput',
  components: {
    'answer-data': AnswerData,
    //'github-user-data': GithubUserData,
  },
  created() {
    console.log("created()");
    bus.$on('new-answer', this.onAnswerChange)
  },
  destroyed() {
    console.log("destroyed()");
    bus.$off('new-answer', this.onAnswerChange)
  },
  methods: {
    onAnswerChange(name) {
      //console.log("onAnswerChange(): " + name);
      this.currentAnswer = name
      this.saveData(name)
      //this.fetchGithubData(name)
    },
    saveData(name) {
      console.log("saveData(): " + name);
      
      if (this.answerData.hasOwnProperty(name)) return
      console.log("process.env.API_PATH: " + process.env.API_PATH);
      const url = process.env.API_PATH;
      var formData = new FormData();
      formData.append('id', '1234');
      formData.append('name', `${name}`);

      //Vue.prototype.$http.post(url, formData).then((response) => {
      this.$http.post(url, formData).then((response) => {
        //success
        console.log("Success: " + response.data);
      }, (response) => {
        //error
        console.log("Error: " + response.data);
      });

    }
/*    
    fetchGithubData(name) {
      //console.log("fetchGithubData(): " + name);
      
      if (this.githubData.hasOwnProperty(name)) return
      //console.log("process.env.API_PATH: " + process.env.API_PATH);
      const url = process.env.API_PATH + `/users/${name}`
      fetch(url).then(r => r.json()).then(data => {
        Vue.set(this.githubData, name, data)
      })
    }
*/    
  },
  data() {
    return {
      currentAnswer: null,
      answerData: {}
    }
  }
}
