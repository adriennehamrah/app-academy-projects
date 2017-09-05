const Util = require('./util.js');
const MovingObject = require('./moving_object.js');

const COLOR = 'green';
const RADIUS = 15;

function Ship(options) {
  let vel = [0, 0];

  let pos = options['pos'];
  let game = options['game'];

  MovingObject.call(this, {'color': COLOR, 'radius': RADIUS, 'pos': pos, 'game': game, 'vel': vel} );
}

Util.inherits(Ship, MovingObject);

Ship.prototype.relocate = function () {
  this.pos = this.randomPosition();
  this.vel = [0, 0];
};

Ship.prototype.randomPosition = function () {
  let posX = Math.floor(Math.random()*500);
  let posY = Math.floor(Math.random()*500);
  return [posX, posY];
};



module.exports  = Ship;
