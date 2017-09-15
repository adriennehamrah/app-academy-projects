import React from 'react';
import {Link} from 'react-router-dom';

const PokemonIndexItem = ({poke}) => (
  <li>
    <Link to = {`/pokemon/${poke.id}`}>
    {poke.name}
    <img className='small' src={poke.image_url} />
    </Link>
  </li>
);

export default PokemonIndexItem;
