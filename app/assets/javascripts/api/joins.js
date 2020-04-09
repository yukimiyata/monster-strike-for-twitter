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
        let isJoined = joins.is_joined;
        let recruitStyle, recruitName, recruitGame;
        for (let i = 0; i < joinedInfo.length; i++) {
            //"参加する"or"参加取り消し"の出しわけ
            recruitStyle = "recruiting-position-style-" + joinedInfo[i][0];
            if(isJoined){
                if(userId == joinedInfo[i][2]){
                    document.getElementById(recruitStyle).style.visibility="visible";
                }else{
                    document.getElementById(recruitStyle).style.visibility="hidden";
                }
            }else{
                if(joinedInfo[i][1]){
                    document.getElementById(recruitStyle).style.visibility="hidden";
                }else{
                    document.getElementById(recruitStyle).style.visibility="visible";
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
            recruitGame = "game-start-" + joinedInfo[i][0];
            if(postStatus){
                if(userId == joinedInfo[i][2]){
                    document.getElementById(recruitStyle).style.visibility="hidden";
                    document.getElementById(recruitGame).textContent = "ゲームスタート"
                }else{
                    document.getElementById(recruitStyle).style.visibility="hidden";
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
