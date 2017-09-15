export const fetchAllPokemon = () => {
  return $.ajax ({
    method: 'GET',
    url: 'api/pokemon'
  });
};

export const fetchSinglePokemon = (pokeId) => {
  return $.ajax ({
    method: 'GET',
    url: `api/pokemon/${pokeId}`
  });
};

export const createPokemon = (pokemon) => {
  return $.ajax ({
    method: 'POST',
    dataType : "json",
    url: 'api/pokemon',
    data: pokemon
  });
};
