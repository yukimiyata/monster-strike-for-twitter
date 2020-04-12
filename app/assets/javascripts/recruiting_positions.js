let setCharacterValue = function (value) {
    let targetTag = document.getElementById("character-number-" + value.className[0]);
    targetTag.value = value.innerHTML;
};

let setDescriptionValue = function (value) {
    let targetTag = document.getElementById("description-number-" + value.className[0]);
    targetTag.value = value.innerHTML;
};
