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
