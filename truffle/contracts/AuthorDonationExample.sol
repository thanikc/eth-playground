// Tell the compiler what version of Solidity we're using.
pragma solidity ^0.4.4;

// TestRPC HD wallet
// warrior minimum breeze raven garden express solar flavor obvious twenty alpha actress
contract AuthorDonation {

  // Accounts for each of the two participants in the contract with the 'address' type.
  address author = 0xb06fdc0b49f3377589437abad432003ab1e612b1;
  address editor = 0x134d09c34c0b628d51e692d68eb4d3899606117b;

  // This method will be called from the Dapp.
  // Any function which uses funds must contain the keyword payable.
  function donate() payable {
    // If no Ether has been sent we have nothing to do.
    if (msg.value == 0) throw;

    // Do some arithmetic for an 80/20 split between Author and Editor.
    // Use a 256 bit unsigned integer that represents the value in wei
        uint editorAmount = msg.value / 5;
        uint authorAmount = msg.value - editorAmount;

    // Attempt to forward Ether to the Author and then the Editor.
    // Throw an exception if transfer fails. Ether is returned to sender.
    if (!author.send(authorAmount)) throw;
    if (!editor.send(editorAmount)) throw;
  }
  
}
