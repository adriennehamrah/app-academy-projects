const APIUtil = require('./api_util.js');


class FollowToggle {
  constructor($followButton) {
    this.$followButton = $followButton;
    this.targetUserId = this.$followButton.data("target-user-id");
    this.currentUserId = this.$followButton.data("current-user-id");
    this.followState = this.$followButton.data("initial-follow-state");

    this.render();
    this.handleClick();
  }

  render() {
    this.$followButton.empty();
    switch (this.followState) {
      case "unfollowed":
        this.$followButton.prop("disabled", false);
        this.$followButton.append("Follow!");
        break;
      case "followed":
        this.$followButton.prop("disabled", false);
        this.$followButton.append("Unfollow!");
        break;
      case "following":
      case "unfollowing":
        this.$followButton.prop("disabled", true);
        break;
      default: this.$followButton.append("Can't find follow state");
    }
  }

  handleClick() {
    this.$followButton.on('click', (event) => {
      event.preventDefault();
      switch (this.followState) {
        case "unfollowed":
          this.followState = 'following';
          this.render();
          APIUtil.followUser(this.targetUserId)
            .then(() => this.toggleFollowState())
            .then(() => this.render())
            .fail(()=> alert('APIUtil error'));
          break;
        case "followed":
          this.followState = 'unfollowing';
          this.render();
          APIUtil.unfollowUser(this.targetUserId)
            .then(() => this.toggleFollowState())
            .then(() => this.render())
            .fail(()=> alert('APIUtil error'));
          break;
        default:alert("Handle Click Error!");

      }
    });
  }

  toggleFollowState(){
    switch (this.followState) {
      case "following":
        this.followState = "followed";
        break;
      case "unfollowing":
        this.followState = "unfollowed";
        break;
      default: alert("SOMETHINGS WRONG");
    }
  }
}

module.exports = FollowToggle;
