<template>
  <div class="hello">
    <h2>{{ msg }}</h2>
    <table>
      <tr><td>Account:</td><td>{{ account }}</td></tr>
      <tr><td>Balance:</td><td>{{ balance }} ETH</td></tr>
    </table>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  created () {
    const web3 = window.web3
    if (typeof web3 !== 'undefined') {
      web3.version.getNetwork((err, netId) => {
        if (err) {
          this.msg = err
          return console.error(err)
        }

        switch (netId) {
          case '3':
            this.msg = 'You are connected to the Ropsten Test Network.'
            this.account = web3.eth.coinbase
            web3.eth.getBalance(this.account, (err, result) => {
              if (!err) {
                this.balance = result / 1000000000000000000
              }
            })
            break
          default:
            this.msg = 'You should switch network to Ropsten Test in order to avoid accidentally transfer real ether into a test account.'
        }
      })
    } else {
      this.msg = 'You need the <a href="https://metamask.io/">MetaMask</a> browser plugin to run this example.'
    }
  },
  data () {
    return {
      msg: 'Welcome to Your Vue.js App',
      account: '-',
      balance: 0.0
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1, h2 {
  font-weight: normal;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
td {
  text-align: left;
}
</style>
