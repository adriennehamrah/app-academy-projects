import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';
import {createPokemon} from './actions/pokemon_actions';

document.addEventListener('DOMContentLoaded', () => {
  const store = configureStore();
  window.dispatch = store.dispatch;
  window.createPokemon = createPokemon;
  ReactDOM.render(<Root store={store} />, document.getElementById('root'));
});
