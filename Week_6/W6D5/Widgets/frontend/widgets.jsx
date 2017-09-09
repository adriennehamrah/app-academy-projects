import React from 'react';
import ReactDOM from 'react-dom';
import Clock from './clock';
import Weather from './weather';
import AutoComplete from './auto';


class Root extends React.Component{

  render(){
    return(
      <div>
        <Clock />
        <Weather />
          <AutoComplete name={['jerry',
                               'anastassia',
                               'adrienne',
                               'rebekah',
                               'david',
                               'tyler',
                               'tommy',
                               'priya',
                               'jimmy',
                               'brian',
                               'isak',
                               'katerina',
                               'allison']} />
      </div>
    );
  }
}

document.addEventListener("DOMContentLoaded", () => {
	const root = document.getElementById("root");
	ReactDOM.render(<Root/>, root);
});
