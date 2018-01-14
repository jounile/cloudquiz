import bus from '../bus'
import Vue from 'vue'

import GithubUserData from '../GithubUserData/index.vue'

export default {
  name: 'QuizOutput',
  components: {
    'github-user-data': GithubUserData,
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
      this.fetchGithubData(name)
    },
    fetchGithubData(name) {
      //console.log("fetchGithubData(): " + name);
      
      if (this.githubData.hasOwnProperty(name)) return
      //console.log("process.env.API_PATH: " + process.env.API_PATH);
      const url = process.env.API_PATH + `/users/${name}`
      fetch(url).then(r => r.json()).then(data => {
        Vue.set(this.githubData, name, data)
      })
    }
  },
  data() {
    return {
      currentAnswer: null,
      githubData: {}
    }
  }
}
