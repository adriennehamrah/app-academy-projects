import {connect} from 'react-redux';
import {createPokemon} from '../../actions/pokemon_actions';
import CreatePokemon from './create_pokemon';
import {withRouter} from 'react-router-dom';

const mapStateToProps = state => ({
  state
});

const mapDispatchToProps = dispatch => ({
  createPokemon: (pokemon) => dispatch(createPokemon(pokemon))
});

export default withRouter(connect(
  mapStateToProps,
  mapDispatchToProps
)(CreatePokemon));
