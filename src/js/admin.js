function updateProjectSelection() {
    var value = document.getElementById("category-selection").value;
    if (value != 0) {
        document.getElementById("project-selection-container").classList.remove("d-none");
    } else {
        document.getElementById("project-selection-container").classList.add("d-none");
        document.getElementById("language-selection-container").classList.add("d-none");
        document.getElementById("supress-button").classList.add("d-none");
    }
    update();
}

function updateLanguageSelection() {
    var value = document.getElementById("project-selection").value;
    if (value != 0) {
        document.getElementById("language-selection-container").classList.remove("d-none");
        document.getElementById("supress-button").classList.remove("d-none");
        document.getElementById("terminologie").classList.remove("d-none");
    } else {
        document.getElementById("language-selection-container").classList.add("d-none");
        document.getElementById("supress-button").classList.add("d-none");
        document.getElementById("terminologie").classList.add("d-none");
    }
    printProject();
    printLanguagesFromProject();
    printCaptionText(false);
}
