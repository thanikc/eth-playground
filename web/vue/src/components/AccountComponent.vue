<template>
  <div>
    <md-content class="md-primary" v-if="metaMaskDetected">MetaMask detected</md-content>
    <md-content class="md-accent" v-if="!metaMaskDetected">
      You should install <a href="https://metamask.io/">MetaMask</a> in order to run the examples in this application.
    </md-content>
    <table>
      <tr><td>Network:</td><td>{{ network }}</td></tr>
      <tr><td>Account:</td><td>{{ account }}</td></tr>
      <tr><td>Balance:</td><td>{{ balance }} ETH</td></tr>
    </table>
  </div>
</template>

<script>
export default {
  name: 'account',
  data: () => ({
    metaMaskDetected: false,
    account: '-',
    balance: 0,
    network: '-'
  }),
  created () {
    const web3 = window.web3
    if (typeof web3 !== 'undefined') {
      this.metaMaskDetected = web3.currentProvider.isMetaMask
      this.account = web3.eth.coinbase
      web3.eth.getBalance(this.account, (err, result) => {
        if (!err) {
          this.balance = result / 1000000000000000000
        }
      })
      web3.version.getNetwork((err, netId) => {
        if (err) {
          return console.err(err)
        }
        switch (netId) {
          case '1':
            this.network = 'Mainnet'
            break
          case '2':
            this.network = 'Deprecated Morden Test'
            break
          case '3':
            this.network = 'Ropsten Test'
            break
          default:
            this.network = `Unknown (netId: ${netId})`
        }
      })
    }
  }
}
</script>
