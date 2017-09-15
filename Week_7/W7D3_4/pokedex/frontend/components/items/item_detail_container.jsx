import {connect} from 'react-redux';
import ItemDetail from './item_detail';
import {withRouter} from 'react-router-dom';
import {selectPokemonItem} from '../../reducers/selectors';


const mapStateToProps = (state, ownProps) => ({
  item: selectPokemonItem(state, ownProps.match.params.itemID)
});

const mapDispatchToProps = dispatch => ({
  // requestAllPokemon: () => dispatch(requestAllPokemon())
});

export default withRouter(connect(
  mapStateToProps,
  mapDispatchToProps
)(ItemDetail));
