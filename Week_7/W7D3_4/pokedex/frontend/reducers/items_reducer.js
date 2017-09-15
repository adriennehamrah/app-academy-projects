import {merge} from 'lodash';
import {RECEIVE_SINGLE_POKEMON} from '../actions/pokemon_actions';

export default (state = {}, action) => {
  Object.freeze(state);
  let nextState = {};
  switch (action.type) {
    case RECEIVE_SINGLE_POKEMON:
      nextState = merge({}, state);
      action.items.forEach(item => {
        nextState[item.id] = item;
      });
      return nextState;
    default:
      return state;
  }
};
