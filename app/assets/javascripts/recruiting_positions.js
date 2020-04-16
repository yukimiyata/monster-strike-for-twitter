let setCharacterValue = function (value) {
    let targetTag = $("#character-number-" + value.className[0])[0];
    targetTag.value = value.innerHTML;
};

let setDescriptionValue = function (value) {
    let targetTag = $("#description-number-" + value.className[0])[0];
    targetTag.value = value.innerHTML;
};
