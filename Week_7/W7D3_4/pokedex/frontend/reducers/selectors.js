import lodash from 'lodash';

const selectAllPokemon = (state) => (
  lodash.values(state.entities.pokemon)
);

export default selectAllPokemon;
