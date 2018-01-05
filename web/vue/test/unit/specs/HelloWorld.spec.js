import Vue from 'vue'
import VueExampleContract from '@/components/VueExampleContract'

describe('VueExampleContract.vue', () => {
  it('should render correct contents', () => {
    const Constructor = Vue.extend(VueExampleContract)
    const vm = new Constructor().$mount()
    expect(vm.$el.querySelector('.hello h1').textContent)
    .to.equal('Welcome to Your Vue.js App')
  })
})
