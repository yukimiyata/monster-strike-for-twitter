window.addEventListener('load', function () {
    changeToFollowingList();
});

let changeToFollowingList = function () {
    $("#current_user_following_list")[0].style.display = "block";
    $("#current_user_blacklisting_list")[0].style.display = "none";
};

let changeToBlacklistingList = function () {
    $("#current_user_following_list")[0].style.display = "none";
    $("#current_user_blacklisting_list")[0].style.display = "block";
};