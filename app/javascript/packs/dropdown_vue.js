import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'

document.addEventListener('turbolinks:load', () => {
  var app = new Vue({
    el: '#nav',
    data: {
        isOpen: false,
        items: [
            {
                url: '#',
                name: 'メニュー',
                children: [
                    {
                        url: '#',
                        name: 'マイページ'
                    },
                    {
                        url: '#',
                        name: '店舗登録'
                    },
                    {
                        url: '/users/sign_out',
                        name: 'ログアウト'
                    },
                ]
            },
        ]
    },
    methods: { 
      open: function () {
          this.isOpen = !this.isOpen;
      }
    }
  });
})