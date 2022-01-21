import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'
import TurbolinksAdapter from 'vue-turbolinks';

Vue.component('star-rating', VueStarRating.default);

Vue.use(TurbolinksAdapter);

let star = new Vue({
  el: '#star',
  data: {
    rating: 0
  }
});