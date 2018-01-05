import Vue from 'vue'
import Router from 'vue-router'
import VueExampleContract from '@/components/VueExampleContract'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'VueExampleContract',
      component: VueExampleContract
    }
  ]
})
