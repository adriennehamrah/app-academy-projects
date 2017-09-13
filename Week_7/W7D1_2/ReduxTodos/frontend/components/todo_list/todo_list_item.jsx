import React from 'react';

const TodoListItem = ({todo, removeTodo, receiveTodo}) => {
  const deleteTodo = (event) => {
    removeTodo(todo);
  };

  const updateTodo = (event) => {
    const newTodo = todo;
    newTodo.done = (newTodo.done === 'false' ? 'true' : 'false');
    removeTodo(todo);
    receiveTodo(todo);
  };

  const isDone = () => {
    return (todo.done === 'false' ? 'Complete' : 'Reopen');
  };

  return (<li>
    <h2 className='title'>{todo.title}</h2>
    <div className='body'>{todo.body}</div>
    <button onClick={deleteTodo}>Delete</button>
    <button onClick={updateTodo}>{isDone()}</button>
  </li>);
};


export default TodoListItem;
