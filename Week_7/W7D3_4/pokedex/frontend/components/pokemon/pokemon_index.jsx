import React from 'react';
import PokemonIndexItem from './pokemon_index_item';
import {Route} from 'react-router-dom';
import PokemonDetailContainer from './pokemon_detail_container';
import ItemDetailContainer from '../items/item_detail_container';

export default class PokemonIndex extends React.Component {

  render() {
    return(
      <div>
        <section className="pokedex">
          <ul>
            {
              this.props.pokemon.map(poke => (
                <PokemonIndexItem key={poke.id} poke={poke}/>
              ))
            }
          </ul>
        </section>
        <Route path='/pokemon/:pokemonID' component={PokemonDetailContainer}/>
        <Route path="/pokemon/:pokemonID/item/:itemID" component={ItemDetailContainer}/>
      </div>
    );
  }

  componentDidMount() {
    this.props.requestAllPokemon();
  }
}
