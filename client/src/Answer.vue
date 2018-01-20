<template>
  <div id="answer">
	<quiz-input></quiz-input>
	<quiz-output></quiz-output>
  </div>
</template>

<script>
import QuizInput from './QuizInput/index'
import QuizOutput from './QuizOutput/index'

export default {
  name: 'QuizInput',
  components: {
    'quiz-input': QuizInput,
    'quiz-output': QuizOutput
  },
}
</script>