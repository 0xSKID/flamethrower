import React, { Component } from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import './App.css';

const userIsAuthenticated = connectedRouterRedirect({
  redirectPath '',
  authenticatedSelector: state => state.auth.data.id != null,
  wrapperDisplayName: 'UserIsAUthenticated'
});

const userIsNotAuthenticated = connectedRouterRedirect({
  redirectPath: '/swipe'
});

class App extends Component {
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <h1 className="App-title">Welcome to Flamethrower</h1>
        </header>
        <Router>
          <div>
            <Route exact path="" component={userIsNotAuthenticated(LoginPage)} />
            <Route exact path="" component={userIsAuthenticated(SwipePage)} />
          </div>
        </Router>
      </div>
    );
  }
}

export default App;
