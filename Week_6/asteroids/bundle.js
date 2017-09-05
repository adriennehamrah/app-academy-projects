/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const GameView = __webpack_require__(1);


const findCtx = function () {
  const canvasEl = document.getElementById("game-canvas");
  const ctx = canvasEl.getContext('2d');
  const g = new GameView(ctx);
  g.start();
};

document.addEventListener("DOMContentLoaded", findCtx);


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

const Game = __webpack_require__(2);


function GameView (ctx) {
  this.game = new Game;
  this.ctx = ctx;
}

GameView.prototype.start = function () {
  setInterval(this.game.step.bind(this.game), 20);
  setInterval(this.game.draw.bind(this.game, this.ctx), 20);
};

module.exports = GameView;


/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

const Asteroid = __webpack_require__(3);
const Ship = __webpack_require__(6);


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


/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const Util = __webpack_require__(4);
const MovingObject = __webpack_require__(5);
const Ship = __webpack_require__(6);

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


/***/ }),
/* 4 */
/***/ (function(module, exports) {

const Util = {
  inherits (Child, Parent) {
    Child.prototype = Object.create(Parent.prototype);
    Child.prototype.constructor = Child;
  }
};

module.exports = Util;


/***/ }),
/* 5 */
/***/ (function(module, exports) {

function MovingObject(options) {
  this.pos = options['pos'];
  this.vel = options['vel'];
  this.radius = options['radius'];
  this.color = options['color'];
  this.game = options['game'];
}

MovingObject.prototype.draw = function (ctx) {
  ctx.fillStyle = this.color;
  ctx.beginPath();

  ctx.arc(
    this.pos[0],
    this.pos[1],
    this.radius,
    0,
    2*Math.PI,
    false
  );
  ctx.fill();
};

MovingObject.prototype.move = function () {
  this.pos[0] += this.vel[0];
  this.pos[1] += this.vel[1];
  this.game.wrap(this.pos);
};

MovingObject.prototype.isCollidedWith = function (otherObj) {

  if (this.distance(this.pos, otherObj.pos) < this.radius + otherObj.radius ) {
    return true;
  } else {
    return false;
  }
};

MovingObject.prototype.collideWith = function (otherObj) {

};



MovingObject.prototype.distance = function (pos1, pos2) {
  return Math.sqrt(Math.pow(pos1[0] - pos2[0], 2) + Math.pow(pos1[1] - pos2[1], 2));
};

module.exports = MovingObject;


/***/ }),
/* 6 */
/***/ (function(module, exports, __webpack_require__) {

const Util = __webpack_require__(4);
const MovingObject = __webpack_require__(5);

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


/***/ })
/******/ ]);