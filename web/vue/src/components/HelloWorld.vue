<template>
  <div class="hello">
    <h2>{{ msg }}</h2>
    <table>
      <tr><td>Account:</td><td>{{ account }}</td></tr>
      <tr><td>Balance:</td><td>{{ balance }} ETH</td></tr>
    </table>
    <fieldset>
      <input type="text" v-model="addressData" placeholder="bytes32 (0x1234...) or string" style="width: 32em;"/>
      <button v-on:click="setStoredData">set Stored Data</button>
      <button v-on:click="getStoredData">get Stored Data</button>
      <pre>{{ lastTransaction }}</pre>
    </fieldset>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  created () {
    this.setupWeb3()
  },
  data: () => ({
    msg: 'Welcome to Your Vue.js App',
    account: '-',
    balance: 0.0,
    addressData: '',
    lastTransaction: ''
  }),
  methods: {
    setupWeb3 () {
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
              this.refreshAccount(web3)
              break
            default:
              this.msg = 'You should switch network to Ropsten Test in order to avoid accidentally transfer real ether into a test account.'
          }
        })
      } else {
        this.msg = 'You need the <a href="https://metamask.io/">MetaMask</a> browser plugin to run this example.'
      }
    },
    refreshAccount (web3) {
      this.account = web3.eth.coinbase
      web3.eth.getBalance(this.account, (err, result) => {
        if (!err) {
          this.balance = result / 1000000000000000000
        }
      })
    },
    getContract () {
      /* created at 0xb9d1dfd5b7bb489cfa333e07ce57dc29c016c32d in Ropsten Test Network
      pragma solidity ^0.4.4;

      contract VueExample {
          bytes32 storedData;

          function set(bytes32 x) public {
              storedData = x;
          }

          function get() public constant returns(bytes32) {
              return storedData;
          }
      }
      */
      return window.web3.eth.contract([
        {
          'constant': true,
          'inputs': [],
          'name': 'get',
          'outputs': [
            {
              'name': '',
              'type': 'bytes32'
            }
          ],
          'payable': false,
          'stateMutability': 'view',
          'type': 'function'
        },
        {
          'constant': false,
          'inputs': [
            {
              'name': 'x',
              'type': 'bytes32'
            }
          ],
          'name': 'set',
          'outputs': [],
          'payable': false,
          'stateMutability': 'nonpayable',
          'type': 'function'
        }
      ]).at('0xb9d1dfd5b7bb489cfa333e07ce57dc29c016c32d')
    },
    getStoredData () {
      const contract = this.getContract()
      contract.get((err, result) => {
        if (!err) {
          alert(window.web3.toAscii(result))
        } else {
          alert(`Error: ${err}`)
        }
      })
    },
    setStoredData () {
      const contract = this.getContract()
      contract.set(this.addressData, (err, result) => {
        if (!err) {
          this.lastTransaction = result
        } else {
          this.lastTransaction = err
        }
      })
    }
  }
}
</script>

<!-- Add 'scoped' attribute to limit CSS to this component only -->
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
