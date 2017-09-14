import { RECEIVE_ALL_POKEMON } from '../actions/pokemon_actions';

export const pokemonReducer = (state = {}, action) => {
  Object.freeze(state);
  switch (action.type) {
    case RECEIVE_ALL_POKEMON:
    let nextState = {};
      action.pokemon.forEach(poke => {
        const p = poke[Object.keys(poke)];
        nextState[p.id] = p;
      });
      return nextState;
    default:
      return state;
  }
};
