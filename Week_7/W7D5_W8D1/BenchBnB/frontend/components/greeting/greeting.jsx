import React from 'react';
import {Link} from 'react-router-dom';

const sessionLinks = () => (
  <div>
    <Link to ="/login">Login</Link>
    <br></br>
    <Link to ="/signup">Sign Up</Link>
  </div>
);

const welcomeMessage = (currentUser, logout) => (
  <div>
    <h2>Welcome, {currentUser.username}!</h2>
    <button onClick={logout}>Logout</button>
  </div>
);

const Greeting = ({currentUser, logout}) => (
  currentUser ? welcomeMessage(currentUser, logout) : sessionLinks()
);

export default Greeting;
