import React from 'react';

class Weather extends React.Component{
  constructor(){
    super();
    this.state = {temp: "", city: ""};
    this.pullWeather = this.pullWeather.bind(this);
  }

  componentDidMount(){
    navigator.geolocation.getCurrentPosition(this.pullWeather);
  }

  pullWeather(position){
    let lat = position.coords.latitude;
    let lon = position.coords.longitude;
    let url = `http://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=bcb83c4b54aee8418983c2aff3073b3b`;
    this.callAjax(url);

  }

  callAjax(url){
    let request = new XMLHttpRequest();
    request.open('GET', url, true);

    request.onload = () => {
      if (request.status >= 200 && request.status < 400) {
        // Success!
        let weather = JSON.parse(request.responseText);
        let temp = Math.floor(this.ktf(weather.main.temp));
        let city = weather.name;
        this.setState({ temp, city});
      } else {
        // We reached our target server, but it returned an error

      }
    };

    request.onerror = function() {
      // There was a connection error of some sort
    };

    request.send();
  }

  ktf(k){
    return k * (9/5) - 459.67;
  }

  render(){
    let { temp, city } = this.state;
    return(
      <div>
        <h1>Dumpling Weather</h1>
        <div className="weather">
          <h4>City: {city}</h4>
          <h4>Temperature: {temp} F</h4>
        </div>
      </div>
    );
  }

}

export default Weather;
