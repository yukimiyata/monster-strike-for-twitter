//recruiting_positonsの1~3人のrenderを切り替えています。
$(function () {
    let recruitDetach1, recruitDetach2, recruitDetach3;
    recruitDetach1 = $("#input-recruiting-positions-form-1").detach();
    recruitDetach2 = $("#input-recruiting-positions-form-2").detach();
    recruitDetach3 = $("#input-recruiting-positions-form-3").detach();
    $("#input-recruiting-position-form").append(recruitDetach3);

    $(".radio-inline__input").click(function () {
        if(this.value == 1){
            if(!$("#input-recruiting-positions-form-1").length) {
                $("#input-recruiting-position-form").append(recruitDetach1);
            }
            if($("#input-recruiting-positions-form-2").length) {
                recruitDetach2 = $("#input-recruiting-positions-form-2").detach();
            }
            if($("#input-recruiting-positions-form-3").length) {
                recruitDetach3 = $("#input-recruiting-positions-form-3").detach();
            }
        }else if(this.value == 2){
            if(!$("#input-recruiting-positions-form-2").length) {
                $("#input-recruiting-position-form").append(recruitDetach2);
            }
            if($("#input-recruiting-positions-form-1").length) {
                recruitDetach1 = $("#input-recruiting-positions-form-1").detach();
            }
            if($("#input-recruiting-positions-form-3").length) {
                recruitDetach3 = $("#input-recruiting-positions-form-3").detach();
            }
        }else if(this.value == 3){
            if(!$("#input-recruiting-positions-form-3").length) {
                $("#input-recruiting-position-form").append(recruitDetach3);
            }
            if($("#input-recruiting-positions-form-1").length) {
                recruitDetach1 = $("#input-recruiting-positions-form-1").detach();
            }
            if($("#input-recruiting-positions-form-2").length) {
                recruitDetach2 = $("#input-recruiting-positions-form-2").detach();
            }
        }
    });
});


window.onload = function () {
    let questBody = document.getElementById("input-quest-body");
    questBody.oninput = checkInputData;

    function checkInputData(e) {
        $.ajax({
            url: "/api/posts",
            type: "GET",
            data: {body: e.target.value},
            dataType: "json"
        }).done(function (data) {
            let questName = data.quest_name;
            console.log(questName);
            document.getElementById("quest-name-display").textContent = questName;
        }).fail(function (data) {
        })
    }
};
