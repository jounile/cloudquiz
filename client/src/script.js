import QuizInput from './QuizInput/index'
import QuizOutput from './QuizOutput/index'

export default {
  name: 'app',
  components: {
    'quiz-input': QuizInput,
    'quiz-output': QuizOutput
  },
  data() {
    return {
      title: 'Cloud Quiz',
      msg: 'Serverless Vue.js App'
    }
  },
}