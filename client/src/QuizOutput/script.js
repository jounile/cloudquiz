import bus from '../bus'
import Vue from 'vue'
import axios from 'axios'

import AnswerData from '../AnswerData/index.vue'

export default {
  name: 'QuizOutput',
  components: {
    'answer-data': AnswerData,
  },
  created() {
    bus.$on('new-answer', this.onAnswerChange)
  },
  destroyed() {
    bus.$off('new-answer', this.onAnswerChange)
  },
  methods: {
    onAnswerChange(name) {
      this.currentAnswer = name
      this.saveData(name)
    },
    saveData(name) {
      console.log("saveData(): " + name);
      
      if (this.answerData.hasOwnProperty(name)) return
      console.log("process.env.API_PATH: " + process.env.API_PATH);
      const url = process.env.API_PATH;
      const random = '' + Math.floor(Math.random() * 9000000000) + 1000000000;
      const data = new Object({ 'id': random, 'name':`${name}`});
      console.log("data: " + JSON.stringify(data));

      axios.post(url, data).then((response) => {
        console.log("Success: " + response.data);
        Vue.set(this.answerData, name, response.data)
      }).catch(error => {
        console.log("Error: " + error);
      });

    }    
  },
  data() {
    return {
      currentAnswer: null,
      answerData: {}
    }
  }
}
