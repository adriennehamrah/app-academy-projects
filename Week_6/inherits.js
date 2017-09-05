Function.prototype.inherits = function (Parent) {
  this.prototype = Object.create(Parent.prototype);
  this.prototype.constructor = this;
};


function MovingObject () {}

function Ship () {}
Ship.inherits(MovingObject);

function Asteroid () {}
Asteroid.inherits(MovingObject);


MovingObject.prototype.move = function () {
  console.log('moves!');
};


Ship.inherits(MovingObject);
Asteroid.inherits(MovingObject);



Ship.prototype.shoot = function () {
  console.log('shoots!');
};

let s = new Ship;
let a = new Asteroid;

s.move();
s.shoot();

a.move();
