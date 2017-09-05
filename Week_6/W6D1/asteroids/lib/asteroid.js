const Util = require('./util.js');
const MovingObject = require('./moving_object.js');
const Ship = require('./ship.js');

const COLOR = 'blue';
const RADIUS = 15;

function Asteroid(options) {
  let velX = (Math.random()*2) - 1;
  let velY = (Math.random()*2) - 1;
  let vel = [velX, velY];

  let pos = options['pos'];
  let game = options['game'];

  MovingObject.call(this, {'color': COLOR, 'radius': RADIUS, 'pos': pos, 'game': game, 'vel': vel} );
}


Util.inherits(Asteroid, MovingObject);


Asteroid.prototype.collideWith = function (otherObj) {
  if (otherObj instanceof Ship) {
    console.log(otherObj);
    Ship.prototype.relocate.call(otherObj);
  }
};

module.exports  = Asteroid;
