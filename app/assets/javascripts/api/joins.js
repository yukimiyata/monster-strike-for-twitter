let jobs;
// 募集主が１時間で停止
let counter = 3600;

window.addEventListener('load', function () {
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
        let postStatus = joins.status;
        let userId = joins.user_id;
        let isJoined = joins.is_joined;
        let postUserId = joins.post_user_id;
        let recruitStyle, recruitName, recruitGameTag, recruitTag;
        for (let i = 0; i < joinedInfo.length; i++) {
            //"参加する"or"参加取り消し"の出しわけ isJoinedは自分が募集のどれかにすでに参加しているかのboolean
            recruitStyle = "recruiting-position-style-" + joinedInfo[i][0];
            recruitTag = document.getElementById(recruitStyle);
            if(isJoined){
                if(userId == joinedInfo[i][2]){
                    recruitTag.style.visibility="visible";
                }else{
                    recruitTag.style.visibility="hidden";
                }
            }else{
                if(joinedInfo[i][1]){
                    recruitTag.style.visibility="hidden";
                }else{
                    recruitTag.style.visibility="visible";
                }
            }

            //参加者の名前の表示非表示
            recruitName = "recruiting-position-name-" + joinedInfo[i][0];
            if(joinedInfo[i][1]){
                document.getElementById(recruitName).textContent = joinedInfo[i][1];
            }else{
                document.getElementById(recruitName).textContent = "";
            }

            //参加リンクの作成
            if(postStatus && userId != postUserId){
                recruitGameTag = document.getElementById("game-start-" + joinedInfo[i][0]);
                recruitTag.style.visibility="hidden";
                if(userId == joinedInfo[i][2]){
                    recruitGameTag.textContent = "ゲームスタート";
                }else{
                    recruitGameTag.href = "#";
                    recruitGameTag.textContent = "募集を締め切りました";
                }
            }
        }
    }).fail(function (joins) {
    });

    counter--;
    if(counter == 0){
        clearInterval(jobs);
    }
}
