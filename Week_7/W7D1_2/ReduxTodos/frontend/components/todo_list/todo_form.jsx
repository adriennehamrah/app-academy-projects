import React from 'react';

class TodoForm extends React.Component{
  constructor(){
    super();
    this.state = {
      title: "",
      body: ""
    };
  }

  linkState(key) {
    return (event) => (this.setState({
      [key]: event.currentTarget.value
    }));
  }

  submitTodo(event){
    this.props.receiveTodo({
      title: this.state.title,
      body: this.state.body,
      done: 'false'
    });
  }

  render(){
    return (
      <div className='todo-form'>
        <h2>Add New Todo</h2>
        <h3>Title</h3>
        <input onChange={this.linkState('title')} value={this.state.value}></input>

        <h3>Body</h3>
        <input onChange={this.linkState('body')} value={this.state.value}></input>

        <button onClick={this.submitTodo.bind(this)}>Submit</button>
      </div>
    );
  }
}

export default TodoForm;
