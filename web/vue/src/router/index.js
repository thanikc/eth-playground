import Vue from 'vue'
import Router from 'vue-router'

import HomeComponent from '@/components/HomeComponent'
import VueExampleContract from '@/components/VueExampleContract'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeComponent
    },
    {
      path: '/storage',
      name: 'storage',
      component: VueExampleContract
    }
  ]
})
