import bus from '../bus'

export default {
  name: 'QuizInput',
  methods: {
    onSubmit(event) {
      if (this.answer && this.answer !== '') {
        //console.log("input: " + this.answer);
        bus.$emit('new-answer', this.answer)
      }
    }
  },
  data() {
    return {
      answer: ''
    }
  }
}
