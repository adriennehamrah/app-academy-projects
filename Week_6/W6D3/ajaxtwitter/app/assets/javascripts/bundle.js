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

const FollowToggle = __webpack_require__(1);
const UserSearch = __webpack_require__(3);


$(() => {
  const $followToggleButtons = $(".follow-toggle");
  $followToggleButtons.each((idx, button) => {
    const $followButton = new FollowToggle($(button));
  });

  const $userSearches = $(".users-search");
  $userSearches.each((idx, search) => {
    const $search = new UserSearch($(search));
  });

});


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);


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


/***/ }),
/* 2 */
/***/ (function(module, exports) {

const APIUtil = {
  followUser: id => {
    return $.ajax({
      url: `/users/${id}/follow`,
      type: 'POST',
      dataType: "JSON",
      // error: (e) => {
        // alert("ajax handleClick error");
        // console.log(e);
      // }
    });
  },

  unfollowUser: id => {
    return $.ajax({
      url: `/users/${id}/follow`,
      type: 'DELETE',
      dataType: "JSON",
      error: (e) => {
        alert("ajax handleClick error");
        console.log(e);
      }
    });
  },

  searchUsers: (queryVal, success) => {
    return $.ajax({
      url: "/users/search",
      type: "GET",
      dataType: "JSON",
      data: {
        query: queryVal
      },
      success: success,
      error: (e) => {
        alert("user search ajax error");
        console.log(e);
      }
    });
  }
};

module.exports = APIUtil;


/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);
const FollowToggle = __webpack_require__(1);

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


/***/ })
/******/ ]);
//# sourceMappingURL=bundle.js.map