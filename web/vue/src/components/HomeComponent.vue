<template>
  <div>
    <h1>Ethereum Playground</h1>
    <h3>Vue.js app inteded for experimenting with ethereum.</h3>
    
    <account></account>
    <br />    
    <md-card>
      <md-card-content>
        Need some Ether for testing? Try <a href="https://faucet.metamask.io/">https://faucet.metamask.io</a>
      </md-card-content>
    </md-card>
  </div>
</template>

<script>
import AccountComponent from '@/components/AccountComponent'

export default {
  name: 'HomeComponent',
  components: {
    'account': AccountComponent
  },
  data: () => ({
    metaMaskDetected: false
  }),
  mounted () {
    const web3 = window.web3
    if (typeof web3 !== 'undefined') {
      this.metaMaskDetected = web3.currentProvider.isMetaMask
    }
  }
}
</script>
