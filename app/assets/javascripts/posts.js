function changeForm(form) {
    let activeForm = document.getElementById("input-recruiting-positions-form-" + form.value);
    activeForm.style.display = 'block';
    let checkingForm;
    for (let i = 1; i <= 3; i++) {
        checkingForm = document.getElementById("input-recruiting-positions-form-" + i);
        if (checkingForm.style.display == "block" && checkingForm != activeForm) {
            checkingForm.style.display = "none";
        }
    }
}

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
