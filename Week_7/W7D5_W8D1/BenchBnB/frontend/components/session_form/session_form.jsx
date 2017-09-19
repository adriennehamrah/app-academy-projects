import React from 'react';
import {Link, withRouter} from 'react-router-dom';

class SessionForm extends React.Component{
  constructor(props){
    super(props);
    this.state = {username: "", password: ""};
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  componentWillReceiveProps(nextProps){
    if(nextProps.loggedIn) {
      this.props.history.push('/');
    }
  }

  update(field) {
    return(e) => this.setState({[field]:e.target.value});
  }

  handleSubmit(e) {
    e.preventDefault();
    const user = Object.assign({}, this.state);
    this.props.processForm(user);
  }

  navLink(){
    if(this.props.formType === 'login'){
      return <Link to='/signup'>Sign up instead</Link>;
    } else {
      return <Link to='/login'>Log in instead</Link>;
    }
  }

  renderErrors(){
    return (
      <ul>
        {this.props.errors.map((error, idx) => (
          <li key={`error-${idx}`}>{error}</li>
        ))}
      </ul>
    );
  }

  render(){
    return (
      <div className = 'login-form-container'>
        <form onSubmit={this.handleSubmit}>
          Welcome to BenchBnb!
          <br/>
          {this.props.formType} below or {this.navLink()}
          {this.renderErrors()}
  
          <div className = 'login-form'>
            <label>Username:
              <input type='text' value={this.state.username}
                     onChange={this.update('username')} />
            </label>
            <br/>
            <label>Password:
              <input type='password' value={this.state.password}
                     onChange={this.update('password')} />
            </label>
            <br/>
            <input type='submit' value='submit'/>
          </div>
        </form>
      </div>
    );
  }
}

export default withRouter(SessionForm);
