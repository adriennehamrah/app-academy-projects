import React from 'react';

class AutoComplete extends React.Component{
  constructor(props){
    super(props);
    this.state = {inputVal: ""};
  }

  cap(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
  }

  render(){
    return (
      <div>
        <br/>

        <label>
          Search Names: <input onChange="" value=""></input>
        </label>

        <ul>
          {
            this.props.name.map(el => (
              <li key={el}>{this.cap(el)}</li>
            ))
          }
        </ul>
      </div>
    );
  }
}

export default AutoComplete;
