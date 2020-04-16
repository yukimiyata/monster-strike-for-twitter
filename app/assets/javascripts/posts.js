//recruiting_positonsの1~3人のrenderを切り替え
$(function () {
    let recruitTagOne = $("#input-recruiting-positions-form-1");
    let recruitTagTwo = $("#input-recruiting-positions-form-2");
    let recruitTagThree = $("#input-recruiting-positions-form-3");
    let recruitDetach1 = recruitTagOne.detach();
    let recruitDetach2 = recruitTagTwo.detach();
    let recruitDetach3 = recruitTagThree.detach();
    let lastFormNumber = 3;
    let inputForm = $("#input-recruiting-position-form");

    inputForm.append(recruitDetach3);

    $(".radio-inline__input").click(function () {
        if (lastFormNumber == 1) {
            if (recruitTagOne.length) {
                recruitDetach1 = recruitTagOne.detach();
            }
        } else if (lastFormNumber == 2) {
            if (recruitTagTwo.length) {
                recruitDetach2 = recruitTagTwo.detach();
            }
        } else if (lastFormNumber == 3) {
            if (recruitTagThree.length) {
                recruitDetach3 = recruitTagThree.detach();
            }
        }

        if (this.value == 1) {
            inputForm.append(recruitDetach1);
            lastFormNumber = 1;
        } else if (this.value == 2) {
            inputForm.append(recruitDetach2);
            lastFormNumber = 2;
        } else if (this.value == 3) {
            inputForm.append(recruitDetach3);
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
    let displayQuestName = $("#quest-name-display")[0];
    let alertTag = $("#invalid-body-alert")[0];

    function checkInputData(e) {
        $.ajax({
            url: "/api/posts",
            type: "GET",
            data: {body: e.target.value},
            dataType: "json"
        }).done(function (data) {
            let isValidData = data.valid_data;
            let questName;
            if (isValidData) {
                questName = data.quest_name;
                displayQuestName.textContent = questName;
                submitButton.removeAttribute("disabled");
                if (alertTag != null) {
                    alertTag.textContent = "";
                }
            } else {
                alertTag.textContent = "ラインの募集文をそのまま貼り付けてください";
                submitButton.setAttribute("disabled", true);
                displayQuestName.textContent = "";
            }
        }).fail(function (data) {
            alertTag.textContent = "エラーが発生しました";
        })
    }
};
