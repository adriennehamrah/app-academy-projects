class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
    this.bindEvents();
  }

  bindEvents() {
   this.$el.on('click', 'li', ( e => {
     const $selection = $(e.currentTarget);
     this.makeMove($selection);
   }));
  }

  makeMove($square) {
    const pos = $square.data('pos');
    const currentPlayer = this.game.currentPlayer;

    try {
      this.game.playMove(pos);
    } catch (err) {
      alert('Invalid Move!');
      return;
    }

    $square.addClass(currentPlayer);

    if (this.game.isOver()) {
      this.$el.off('click');
      // this.$el.addClass('gameOver');
      const winner = this.game.winner();

      const $figcaption = $('<figcaption>');

      if (winner) {
        $figcaption.html(`${winner} wins!`);
      } else {
        $figcaption.html(`It's a tie.`);
      }

      this.$el.append($figcaption);
    }
  }

  setupBoard() {
    const $ul = $('<ul>');
    $ul.addClass('clearfix');

    for(let row = 0; row < 3; row++) {
      for(let col = 0; col < 3; col++) {
        let $li = $('<li>');
        $li.data('pos', [row, col]);
        $ul.append($li);
      }
    }
    this.$el.append($ul);
  }
}

module.exports = View;
