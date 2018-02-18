import React, { Component } from 'react';
import Rails from './api.js';

class App extends Component {
  constructor(props) {
    super(props)
    console.log('whaaat');
    Rails.accounts();
  }
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <h1 className="App-title">Welcome to Flamethrower</h1>
        </header>
      </div>
    );
  }
}

export default App;
