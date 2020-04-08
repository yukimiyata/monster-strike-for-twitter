let timer;
// 募集主が１時間で停止
let counter = 1800;

window.addEventListener('load', function () {
    timer = setInterval("statusAjax()", 2000);
});

function statusAjax() {
    let postNumber = location.href.split("/")[location.href.split("/").length - 1];
    $.ajax({
        url: "/api/joins",
        type: "GET",
        data: {id: postNumber},
        dataType: "json"
    }).done(function (joins) {
        let joinedInfo = joins.joins_info;
        let postStatus = joins.status;
        let userId = joins.user_id;
        let postUserId = joins.post_user_id;
        let recruitingIdName, recruitingTag, gameStartIdName, gameStartTag, gameCloseIdName,
            game_close_tag;
        for (let i = 0; i < joinedInfo.length; i++) {
            if (joinedInfo[i][1]) {
                recruitingIdName = "recruiting-position-name-" + joinedInfo[i][0];
                recruitingTag = document.getElementById(recruitingIdName);
                recruitingTag.textContent = joinedInfo[i][1] + "さん";
                if (postStatus) {
                    if (userId == joinedInfo[i][2]) {
                        gameStartIdName = "game-start-" + joinedInfo[i][0];
                        gameStartTag = document.getElementById(gameStartIdName);
                        gameStartTag.textContent = "ゲームを開始する";
                        gameStartTag.href = '/game_starts/' + postNumber;
                    }
                }
            } else {
                if (postStatus) {
                    if (userId != postUserId) {
                        gameCloseIdName = "game-close-" + joinedInfo[i][0];
                        game_close_tag = document.getElementById(gameCloseIdName);
                        game_close_tag.textContent = '募集を締め切りました';
                        game_close_tag.href = "#";
                    }
                }
            }
        }
    }).fail(function (joins) {
    });

    counter--;
    if(counter == 0){
        clearInterval(timer);
    }
}
