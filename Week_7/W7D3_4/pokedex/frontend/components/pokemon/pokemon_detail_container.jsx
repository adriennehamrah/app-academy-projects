import {connect} from 'react-redux';
import {selectSinglePokemon} from '../../reducers/selectors';
import {requestSinglePokemon} from '../../actions/pokemon_actions';
import PokemonDetail from './pokemon_detail';
import {withRouter} from 'react-router-dom';

const mapStateToProps = state => ({
  state
});

const mapDispatchToProps = dispatch => ({
  requestSinglePokemon: (pokeID) => dispatch(requestSinglePokemon(pokeID))
});

export default withRouter(connect(
  mapStateToProps,
  mapDispatchToProps
)(PokemonDetail));
