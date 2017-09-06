class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;
    this.fromPileIdx = null;

    this.$el.on('click', 'ul', this.clickTower.bind(this));

    this.setUpTowers();
    this.render();
  }

  clickTower(e) {
    const selectedPileIdx = $(e.currentTarget).index();

    if (this.fromPileIdx === null) {
      this.fromPileIdx = selectedPileIdx;
    } else {
      if (!this.game.move(this.fromPileIdx, selectedPileIdx)){
        alert('Invalid move!');
      }
      this.fromPileIdx = null;
    }

    this.render();

    const $figcaption = $('<figcaption>');

    if (this.game.isWon()) {
      this.$el.off('click');
      $figcaption.html('You Won!!');
      this.$el.append($figcaption);
    }
  }

  setUpTowers() {
    this.$el.addClass('clearfix');

    for (let pile = 0; pile < 3; pile++) {
      const $pile = $('<ul>');
      $pile.addClass('clearfix');

      for (let disc = 0; disc < 3; disc++) {
        const $disc = $('<li>');
        // $disc.data("size", disc);
        $pile.append($disc);
      }
      this.$el.append($pile);
    }
  }

  render() {
    const $piles = this.$el.find('ul');
    $piles.removeClass();

    if (this.fromPileIdx) {
      const $currentPile = $piles.eq(this.fromPileIdx);
      $currentPile.addClass('selected');
    }

    this.game.towers.forEach( (pile, pileIdx) => {
      const $discs = $piles.eq(pileIdx).children();
      $discs.removeClass();

      pile.forEach( (discSize, discIdx) => {
        const $disc = $discs.eq(-1 * (discIdx + 1));

        $disc.addClass(`disc${discSize}`);
      });
    });
  }
}

module.exports = View;
