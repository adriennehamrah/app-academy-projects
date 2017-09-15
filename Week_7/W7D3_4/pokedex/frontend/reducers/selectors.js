import lodash from 'lodash';

export const selectAllPokemon = (state) => (
  lodash.values(state.entities.pokemon)
);

export const selectPokemonItem = (state, itemID) => (
  state.entities.items[itemID]
);
