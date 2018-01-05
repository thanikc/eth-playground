<template>
  <div>
    
    <h2>{{ msg }}</h2>
    
    <account></account>
    
    <md-field>
      <label>Data Input</label>
      <md-input v-model="storedData"></md-input>
      <span class="md-helper-text">bytes32 (0x1234...) or string</span>
    </md-field>
    <md-button v-on:click="getStoredData" class="md-raised md-primary">get Stored Data</md-button>
    <md-button v-on:click="setStoredData" class="md-raised md-accent">set Stored Data</md-button>

    <md-card v-if="lastTransaction.address">
      <md-card-header>
        <div class="md-title">Last Transaction</div>
      </md-card-header>
      <md-card-content>
        <pre>{{ lastTransaction.receipt }}</pre>
      </md-card-content>
      <md-card-actions>
        <md-button @click="updateTransactionReceipt(lastTransaction.address)">Refresh</md-button>
      </md-card-actions>
    </md-card>

  </div>
</template>

<script>
import AccountComponent from '@/components/AccountComponent'

export default {
  name: 'VueExampleContract',
  components: {
    'account': AccountComponent
  },
  data: () => ({
    msg: '',
    storedData: '',
    lastTransaction: { address: null, receipt: null }
  }),
  created () {
    this.setupWeb3()
  },
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
              this.msg = ''
              break
            default:
              this.msg = 'You must switch to Ropsten Test Network in order for this example to work correctly.'
          }
        })
      } else {
        this.msg = 'You need the <a href="https://metamask.io/">MetaMask</a> browser plugin to run this example.'
      }
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
        if (err) {
          console.log(`Error: ${err}`)
        } else {
          this.storedData = window.web3.toAscii(result)
        }
      })
    },
    setStoredData () {
      const contract = this.getContract()
      contract.set(this.storedData, (err, result) => {
        if (err) {
          console.error(err)
        } else {
          this.lastTransaction.address = result
          this.updateTransactionReceipt(result)
        }
      })
    },
    updateTransactionReceipt (transaction) {
      window.web3.eth.getTransactionReceipt(transaction, (err, res) => {
        if (err) {
          console.error(err)
        } else {
          this.lastTransaction.receipt = JSON.stringify(res, null, 2)
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
  pre {
    text-align: left;
  }
</style>
