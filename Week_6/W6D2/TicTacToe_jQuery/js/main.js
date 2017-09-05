const View = require('./ttt-view');
const Game = require('./game');

$( () => {
  const containerEl = $('.ttt');
  const game = new Game();
  new View (game, containerEl);
});
