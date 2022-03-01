import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'
import TurbolinksAdapter from 'vue-turbolinks';

Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
    const app = new Vue({
      el: '#img_field',
      data: {
        imageData: ''
      },
      methods: {
        onFileChange(e) {
  
          const files = e.target.files;
  
          if(files.length > 0) {
  
              const file = files[0];
              const reader = new FileReader();
              reader.onload = (e) => {
  
                  this.imageData = e.target.result;
  
              };
              reader.readAsDataURL(file);
          }
        }
      },
      components: { App }
    })
  })