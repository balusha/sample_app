window.onload = function () {

    function getCharsUsed() {
        return this.textLength || 0;
    }

    function getCharsLimit(elem) {
        var defaultValue = 100;
        if (elem.attributes.charslimit) {
            var limit = Number(elem.attributes.charslimit.value);
        }
        return limit || defaultValue;
    }

    limitFields = document.getElementsByClassName("charsLeftIndicator");
    for (var i = limitFields.length - 1; i >= 0; i--) {
        var elem = limitFields[i];
        var valueSource = document.getElementById(elem.attributes.valueSource.value);
        var charsLimit = getCharsLimit(valueSource);
        valueSource.getCharsUsed = getCharsUsed;
        valueSource.onkeyup = function () {
            elem.textContent = charsLimit - this.getCharsUsed();
        }
    }
    ;
}