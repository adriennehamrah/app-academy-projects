import React from 'react';
import { Provider } from 'react-redux';
import PokemonContainer from './pokemon/pokemon_index_container';
const Root = ({ store }) => (
  <Provider store={store}>
    <PokemonContainer />
  </Provider>
);

export default Root;
