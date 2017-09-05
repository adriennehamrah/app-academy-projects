const GameView = require('./game_view.js');


const findCtx = function () {
  const canvasEl = document.getElementById("game-canvas");
  const ctx = canvasEl.getContext('2d');
  const g = new GameView(ctx);
  g.start();
};

document.addEventListener("DOMContentLoaded", findCtx);
