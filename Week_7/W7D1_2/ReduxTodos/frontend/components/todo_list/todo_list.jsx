import React from 'react';
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form.jsx';

const TodoList = ({todos, receiveTodo, removeTodo}) => {
  const todoElements = todos.map((todo, idx) => (
      <TodoListItem
        key={todo.id + todo.title}
        todo={todo}
        removeTodo={removeTodo}
        receiveTodo={receiveTodo}/>
    )
  );
  return (
    <div className = "list">
      <h1>Todos</h1>
      <ul className = "list-todos">
        {todoElements}
      </ul>
      <TodoForm receiveTodo={receiveTodo}/>
    </div>
  );
};

export default TodoList;
