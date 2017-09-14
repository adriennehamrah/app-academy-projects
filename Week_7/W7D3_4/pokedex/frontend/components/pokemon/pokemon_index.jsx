import React from 'react';

export default class PokemonIndex extends React.Component {

  render() {
    return(
      <ul>
        {
          this.props.pokemon.map(poke => (
            <li key={poke.id}>
              {poke.name}
              <img className='small' src={poke.image_url} />
            </li>
          ))
        }
      </ul>
    );
  }

  componentDidMount() {
    this.props.requestAllPokemon();
  }
}
