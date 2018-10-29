import React from 'react';
import logo from './logo.svg';
import axios from 'axios';

import './App.css';

class App extends React.Component {

  componentDidMount() {
    axios.get("/api/test").then(data => {
      console.log("Api Response", data);
    });
  }

  render() {
    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h1>Success!</h1>
          <a
            className="App-link"
            href="https://reactjs.org"
            target="_blank"
            rel="noopener noreferrer"
          >
            Learn React
          </a>
        </header>
      </div>
    );
  }
}

export default App;
