import React from 'react';
import {Link} from 'react-router-dom';

export default class PokemonDetail extends React.Component {

  render() {
    const pokeID = this.props.state.ui.pokeDisplay;
    if (pokeID) {
      const pokemon = this.props.state.entities.pokemon[pokeID];
      const items = pokemon.item_ids.map( id => {
        return this.props.state.entities.items[id];
      });
      return(
        <div>
          <img src={pokemon.image_url} />
          <h2>{pokemon.name}</h2>
          <p>Type: {pokemon.poke_type}</p>
          <p>Attack: {pokemon.attack}</p>
          <p>Defense: {pokemon.defense}</p>
          <p>Moves: {pokemon.moves.join(", ")} </p>
          <ul>
            <h2>Items</h2>
            {items.map(item => (
              <li className='item-preview' key={item.id}>
                <Link to={`/pokemon/${pokemon.id}/item/${item.id}`} >
                  <img src={item.image_url} />
                </Link>
              </li>
            ))}
          </ul>
          </div>
        );
    } else {
      return <div></div>;
    }
  }

  componentDidMount() {
    this.props.requestSinglePokemon(this.props.match.params.pokemonID);
  }

  componentWillReceiveProps(newProps) {
    if (this.props.match.params.pokemonID !== newProps.match.params.pokemonID )
    this.props.requestSinglePokemon(newProps.match.params.pokemonID);
  }
}
