const Asteroid = require('./asteroid.js');
const Ship = require('./ship.js');


function Game () {
  this.DIM_X = 500,
  this.DIM_Y = 500,
  this.NUM_ASTEROIDS = 10,
  this.asteroids = [];

  this.addAsteroids();
  this.ship = new Ship(
    {'pos': this.randomPosition(), 'game': this}
  );
}

Game.prototype.randomPosition = function () {
  let posX = Math.floor(Math.random()*500);
  let posY = Math.floor(Math.random()*500);
  return [posX, posY];
};

Game.prototype.addAsteroids = function () {
  while (this.asteroids.length < this.NUM_ASTEROIDS) {
    this.asteroids.push(new Asteroid(
      {'pos': this.randomPosition(), 'game': this}
    ));
  }
};

Game.prototype.allObjects = function () {
  return this.asteroids.concat(this.ship);
};

Game.prototype.moveObjects = function () {
  this.allObjects().forEach((el) => {
    el.move();
  });
};

Game.prototype.draw = function (ctx) {
  ctx.clearRect(0,0,this.DIM_X, this.DIM_Y);
  this.allObjects().forEach((el) => {
    el.draw(ctx);
  });
};

Game.prototype.wrap = function (pos) {
  if (pos[0] > this.DIM_X) {
    pos[0] -= this.DIM_X;
  } else if (pos[0] < 0) {
    pos[0] += this.DIM_X;
  }
  if (pos[1] > this.DIM_Y) {
    pos[1] -= this.DIM_Y;
  } else if (pos[1] < 0) {
    pos[1] += this.DIM_Y;
  }
};

Game.prototype.checkCollisions = function () {
  this.allObjects().forEach((el1) => {
      this.allObjects().forEach((el2) => {
        if (el1 === el2) {
        } else if (el1.isCollidedWith(el2)) {
          el1.collideWith(el2);
        }
      });
  });
};

Game.prototype.step = function () {
  this.moveObjects();
  this.checkCollisions();
};

Game.prototype.remove = function (asteroid) {
  let index = this.asteroids.indexOf(asteroid);
  this.asteroids.splice(index, 1);
};

module.exports = Game;
