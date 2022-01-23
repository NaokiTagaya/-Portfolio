import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'
import TurbolinksAdapter from 'vue-turbolinks';

const StarRating = window.VueStarRating.default;

Vue.component('star-rating', VueStarRating.default);
Vue.use(TurbolinksAdapter);
new Vue({
    el: '#app',
    methods: {
      setRating: function(rating){
        this.rating= rating;
      }
    },
    data: {
      rating: 0
    }
  });