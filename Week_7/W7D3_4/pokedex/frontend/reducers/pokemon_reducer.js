import {merge} from 'lodash';
import {
  RECEIVE_ALL_POKEMON,
  RECEIVE_SINGLE_POKEMON,
  RECEIVE_NEW_POKEMON
 } from '../actions/pokemon_actions';

export const pokemonReducer = (state = {}, action) => {
  Object.freeze(state);
  let nextState = {};
  switch (action.type) {
    case RECEIVE_ALL_POKEMON:
      action.pokemon.forEach(poke => {
        const p = poke[Object.keys(poke)];
        nextState[p.id] = p;
      });
      return nextState;
      case RECEIVE_SINGLE_POKEMON:
        nextState = merge({}, state);
        action.pokemon['item_ids'] = action.items.map( el => el.id );
        nextState[action.pokemon.id] = action.pokemon;
        return nextState;
      case RECEIVE_NEW_POKEMON:
        nextState = merge({}, state);
        debugger;
        nextState[action.pokemon.id] = action.pokemon;
        return nextState;
    default:
      return state;
  }
};
