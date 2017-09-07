const FollowToggle = require("./follow_toggle.js");
const UserSearch = require("./users_search.js");


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
