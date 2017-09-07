const APIUtil = require('./api_util.js');
const FollowToggle = require("./follow_toggle.js");

class UsersSearch {
  constructor($search) {
    this.$search = $search;
    this.$input = $search.children("input");
    this.$usersList = $search.children(".users");
    this.handleInput();
    this.foundUsers;
  }

  handleInput() {
    this.$input.keyup(() => {
      const foundUsers = APIUtil.searchUsers(this.$input.val(),
        (responseJSON) => {this.renderResults(responseJSON);});
    });
  }

  renderResults(foundUsers) {
    console.log(foundUsers);
    this.$usersList.empty();
    foundUsers.forEach((user) => {
      const $user = $(`<li><a href='/users/${user.id}'>
                    ${user.username}
                    </a>
                    <button type="button"
                      data-target-user-id="${user.id}"
                      data-initial-follow-state="${user.followed ? 'followed' : 'unfollowed'}"
                      class="follow-toggle">
                    </button>
                    </li>`);
      this.$usersList.append($user);
    });
    const $followToggleButtons = $(".follow-toggle");
    $followToggleButtons.each((idx, button) => {
      const $followButton = new FollowToggle($(button));
    });
  }
}


module.exports = UsersSearch;
