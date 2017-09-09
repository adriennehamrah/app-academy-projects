import React from 'react';

class Clock extends React.Component{
  constructor(){
    super();
    this.state = {time: new Date()};
    this.tick = this.tick.bind(this);
  }

  componentDidMount(){
    // this.intervalId = setInterval(this.tick(), 1000);
    this.intervalId = setInterval(this.tick, 1000);
  }

  componentWillUnmount(){
    clearInterval(this.intervalId);
  }

  tick(){
    // return () => this.setState({time: new Date()});
    this.setState({time: new Date()});
  }

  render(){
    let hours = this.state.time.getHours();
    let minutes = this.state.time.getMinutes();
    let seconds = this.state.time.getSeconds();
    let timeZone = this.state.time.getTimezoneOffset();
    let fullString = this.state.time.toDateString();

    return (
      <div>
        <h1>Food Clock</h1>

        <div className="clock">
          <h4>Time: </h4>
          <h4> {hours} : {minutes} : {seconds} </h4>
        </div>

        <div className="date">
          <h4>Date: </h4>
          <h4> {fullString} </h4>
        </div>

      </div>
    );
  }
}

export default Clock;
