import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import {receiveTodos, receiveTodo} from './actions/todo_actions';
import App from './components/app.jsx';
import Root from './components/root.jsx';
import {allTodos} from './reducers/selectors.js';
import {apiRequest} from './util/todo_api_util';
const store = configureStore();
window.store = store;
window.apiRequest = apiRequest;

window.receiveTodos = receiveTodos;
window.receiveTodo = receiveTodo;
window.allTodos = allTodos;

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
     <Root store={store} />,
    document.getElementById('main')
  );
});
