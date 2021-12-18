import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'

document.addEventListener('turbolinks:load', () => {
  let vm = new Vue({
    el: '#tab',
    data: {
      isActive: 1
    },
    methods: { 
      activate(num){
        this.isActive = num;
      }
    }
   });
})