import * as APIUtil from '../util/api_util';

export const RECEIVE_ALL_POKEMON = "RECEIVE_ALL_POKEMON";
export const RECEIVE_SINGLE_POKEMON = "RECEIVE_SINGLE_POKEMON";
export const RECEIVE_NEW_POKEMON = "RECEIVE_NEW_POKEMON";

export const receiveAllPokemon = (pokemon) => ({
  type: RECEIVE_ALL_POKEMON,
  pokemon
});

export const receiveSinglePokemon = ({pokemon, items}) => ({
  type: RECEIVE_SINGLE_POKEMON,
  pokemon,
  items
});

export const receiveNewPokemon = ({pokemon}) => ({
  type: RECEIVE_NEW_POKEMON,
  pokemon
});

export const requestAllPokemon = () => (dispatch) => (
  APIUtil.fetchAllPokemon()
    .then(pokemon => dispatch(receiveAllPokemon(pokemon)))
);

export const requestSinglePokemon = (pokeId) => (dispatch) => (
  APIUtil.fetchSinglePokemon(pokeId)
    .then(pokemon => dispatch(receiveSinglePokemon(pokemon)))
);

export const createPokemon = (pokemon) => (dispatch) => (
  APIUtil.createPokemon(pokemon)
    .then(pokemonResponse => dispatch(receiveNewPokemon(pokemonResponse)))
);
