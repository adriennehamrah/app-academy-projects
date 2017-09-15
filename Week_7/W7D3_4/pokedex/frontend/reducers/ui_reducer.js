import {merge} from 'lodash';
import { RECEIVE_SINGLE_POKEMON } from '../actions/pokemon_actions';


const defaultState = {
  pokeDisplay : '',
  errors : {},
  loading: {}
};

export const UIReducer = (state = defaultState, action) => {
  Object.freeze(state);
  switch (action.type) {
    case RECEIVE_SINGLE_POKEMON:
      let nextState = merge({}, state);
      nextState['pokeDisplay'] = action.pokemon.id;
      return nextState;
    default:
      return state;
  }
};
