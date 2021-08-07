const fs = require('fs');
const Account = require('./Account');

// Get wallet address & privat key
const CONTRACT_ADDRESS = fs.readFileSync('../.address', {encoding: "utf8"});
console.log(CONTRACT_ADDRESS);

const Web3 = require('web3');
const web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'));
const abi = require('../build/contracts/MoneyPrinter.json');
const account = new Account();


const contract = new web3.eth.Contract( abi.abi,CONTRACT_ADDRESS);


// Read the logs and parse the wallet info
account.check();

// Start Dev Env and send 1 ether to the contract
const startDev = () => {

  const accDetails = fs.readFileSync(`./../.account`, {
    encoding: "utf8"
  });
  const keyArray = accDetails.split("\n");
  const addr = keyArray[0];
  const key = keyArray[1];


  console.log(addr, key);
  const accObj = web3.eth.accounts.privateKeyToAccount(key);
  const wallet = web3.eth.accounts.wallet.add(accObj);
  // console.log(web3.eth.accounts.wallet)

  console.log("------------------------++++++++++++++\n" + wallet.address);

  web3.eth.sendTransaction({
    "from": wallet.address,
    "to": CONTRACT_ADDRESS,
    "value": web3.utils.toWei("1", 'ether'),
    "gas": 1571410
  }, (err, res) => {
    if (err) throw err;
    console.log(res);
  });


}
setTimeout(() => {
  startDev();
}, 500);
