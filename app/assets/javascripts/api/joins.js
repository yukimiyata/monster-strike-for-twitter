let jobs;
// 募集主が１時間で停止
let counter = 3600;

window.addEventListener('load', function () {
    statusAjax();
    jobs = setInterval("statusAjax()", 1000);
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
        let postStatus = joins.post_status;
        let currentUserId = joins.user_id;
        let isJoined = joins.is_joined;
        let postUserId = joins.post_user_id;
        let postUrl = joins.post_url;
        let recruitNameTag, recruitGameTag, recruitTag, recruitPositionId, joinedUserName, joinedUserId;

        $.each(joinedInfo, function (index, info) {
            recruitPositionId = info[0];
            joinedUserName = info[1];
            joinedUserId = info[2];

            recruitTag = $("#recruiting-position-style-" + recruitPositionId)[0];
            recruitNameTag = $("#recruiting-position-name-" + recruitPositionId)[0];
            recruitGameTag = $("#game-start-" + recruitPositionId)[0];

            //"参加する"or"参加取り消し"のタグの表示非表示分岐 isJoinedは自分が募集のどれかにすでに参加しているかのboolean
            if (isJoined) {
                // 募集に参加している時に、自分がユーザーであればタグを表示、そうでなければ非表示
                if (currentUserId == joinedUserId) {
                    recruitTag.style.visibility = "visible";
                } else {
                    recruitTag.style.visibility = "hidden";
                }
            } else {
                // 参加者がいる場合は隠す(自分は募集に参加していない)
                if (joinedUserId) {
                    recruitTag.style.visibility = "hidden";
                } else {
                    recruitTag.style.visibility = "visible";

                }
            }

            //参加者の名前の表示非表示
            if (joinedUserName) {
                recruitNameTag.textContent = joinedUserName;
            } else {
                recruitNameTag.textContent = "";
            }

            //参加リンクの作成
            // postがstartedになり、postの所有者とログインユーザーが一致しない場合
            if (postStatus && currentUserId != postUserId) {
                recruitTag.style.display = "none";
                // current_userと参加ユーザーが一致する場合
                if (currentUserId == joinedUserId) {
                    recruitGameTag.textContent = "ゲームスタート";
                    recruitGameTag.href = postUrl;
                } else {
                    //参加していなかった場合
                    if(!isJoined) {
                        recruitGameTag.href = "#";
                        recruitGameTag.textContent = "募集を締め切りました";
                    }
                }
            }
        });
    }).fail(function (joins) {
        // 保留
    });

    counter--;
    if (counter == 0) {
        clearInterval(jobs);
    }
}
