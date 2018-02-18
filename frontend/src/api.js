import axios from 'axios';

function accounts() {
  axios.get('/accounts')
    .then(function(response) {
      console.log(response);
    })
    .catch(function(error) {
      console.log(error);
    });
}

const Rails = {
  accounts: accounts
};

export default Rails
