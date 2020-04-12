//recruiting_positonsの1~3人のrenderを切り替え
$(function () {
    let recruitDetach1 = $("#input-recruiting-positions-form-1").detach();
    let recruitDetach2 = $("#input-recruiting-positions-form-2").detach();
    let recruitDetach3 = $("#input-recruiting-positions-form-3").detach();
    let lastFormNumber = 3;

    $("#input-recruiting-position-form").append(recruitDetach3);

    $(".radio-inline__input").click(function () {
        if(lastFormNumber == 1){
            if($("#input-recruiting-positions-form-1").length) {
                recruitDetach1 = $("#input-recruiting-positions-form-1").detach();
            }
        }else if(lastFormNumber == 2){
            if($("#input-recruiting-positions-form-2").length) {
                recruitDetach2 = $("#input-recruiting-positions-form-2").detach();
            }
        }else if(lastFormNumber == 3){
            if($("#input-recruiting-positions-form-3").length) {
                recruitDetach3 = $("#input-recruiting-positions-form-3").detach();
            }
        }

        if(this.value == 1){
            if(!$("#input-recruiting-positions-form-1").length) {
                $("#input-recruiting-position-form").append(recruitDetach1);
            }
            lastFormNumber = 1;
        }else if(this.value == 2){
            if(!$("#input-recruiting-positions-form-2").length) {
                $("#input-recruiting-position-form").append(recruitDetach2);
            }
            lastFormNumber = 2;
        }else if(this.value == 3){
            if(!$("#input-recruiting-positions-form-3").length) {
                $("#input-recruiting-position-form").append(recruitDetach3);
            }
            lastFormNumber = 3;
        }
    });
});

// api/postsにアクセスして、クエスト名を非同期に出す処理
window.onload = function () {
    let questBody = document.getElementById("input-quest-body");
    questBody.oninput = checkInputData;
    let submitButton = document.getElementById("submit-new-post");
    submitButton.setAttribute("disabled", true);

    function checkInputData(e) {
        $.ajax({
            url: "/api/posts",
            type: "GET",
            data: {body: e.target.value},
            dataType: "json"
        }).done(function (data) {
            let isValidData = data.valid_data;
            let questName;
            let displayQuestName = document.getElementById("quest-name-display");
            let alertTag = document.getElementById("invalid-body-alert");
            if(isValidData) {
                questName = data.quest_name;
                displayQuestName.textContent = questName;
                submitButton.removeAttribute("disabled");
                if(alertTag != null){
                    alertTag.textContent = "";
                }
            }else{
                alertTag.textContent = "ラインの募集文をそのまま貼り付けてください";
                submitButton.setAttribute("disabled", true);
                displayQuestName.textContent = "";
            }
        }).fail(function (data) {
            document.getElementById("invalid-body-alert").textContent = "エラーが発生しました";
        })
    }
};
