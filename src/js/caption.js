var ev;
let divImg = document.getElementById("show-img");
divImg.onclick = function(e) {
    ev = e;
    captionForm(); 
}
document.getElementById("submitCap").onclick = function(e) {
    let desc = document.getElementById("descCap");
    addCaption(ev, desc.value, editable); 
    document.getElementById("closeCap").click();
    desc.value = "";
}

function captionForm() {
    document.getElementById("create-caption-container").classList.remove("d-none");
    document.getElementById("triggerCap").click();
}


var xhrUpdate = createXhrObject();
if (!xhrUpdate) {
    window.alert("Objet XMLHTTPRequest non pris en charge par votre navigateur");
}
function changeText(text, nb) {
    let category = document.getElementById("category-selection");
    let project = document.getElementById("project-selection");
    let language = document.getElementById("language-selection").selectedOptions[0].label;
    let value_cat = category.options[category.selectedIndex].text;
    let value_proj = project.options[project.selectedIndex].text;
    let url = "Controller/updateCaptionText.php?title=" + value_proj + "&cat=" + value_cat + "&lang=" + language
        + "&text=" + text + "&cap_id=" + nb;
    xhrUpdate.open("GET", url, false);
    xhrUpdate.send(null);
}



function addCaption(e, desc, editable) {
    var svg = document.getElementById("svg");
    let language = document.getElementById("language-selection").selectedOptions[0].label;
    let pt = svg.createSVGPoint();
    pt.x = e.clientX;
    pt.y = e.clientY;
    let cursor =  pt.matrixTransform(svg.getScreenCTM().inverse());
    const svgns = "http://www.w3.org/2000/svg";
    let text = document.createElementNS(svgns, "text");
    let x = cursor.x;
    let y = cursor.y;
    text.setAttribute("x", x);
    text.setAttribute("y", y);
    text.setAttribute("fill", "red");
    text.setAttribute("font-size", "28px");
    let value = getNumber(x, y, language, desc);
    let id = "Caption" + value;
    text.setAttribute("id", id);
    text.innerHTML = value;
    svg.appendChild(text);
    printCaptionText(editable);
}

var xhrCap = createXhrObject();
if (!xhrCap) {
    window.alert("Objet XMLHTTPRequest non pris en charge par votre navigateur");
}

function getNumber(x, y, language, desc) {
    let category = document.getElementById("category-selection");
    let project = document.getElementById("project-selection");
    let value_cat = category.options[category.selectedIndex].text;
    let value_proj = project.options[project.selectedIndex].text;
    let url = "Controller/number.php?title=" + value_proj + "&cat=" + value_cat + "&x=" + x 
        +"&y=" + y + "&lang=" + language + "&text=" + desc;
    xhrCap.open("GET", url, false);
    xhrCap.send(null);
    let result = "";
    if (xhrCap.status == 200) {
        result = xhrCap.responseText;
    }
    return result;
}

function printCaptions() {
    let category = document.getElementById("category-selection");
    let project = document.getElementById("project-selection");
    let value_cat = category.options[category.selectedIndex].text;
    let value_proj = project.options[project.selectedIndex].text;
    let url = "Controller/getCaptions.php?title=" + value_proj + "&cat=" + value_cat;
    xhrCap.open("GET", url, false);
    xhrCap.send(null);
    if (xhrCap.status == 200) {
        let array = JSON.parse(xhrCap.responseText);
        for (let i = 0; i < array.length; ++i) {
            let svg = document.getElementById("svg");
            let caption_id = array[i].caption_id;
            let x = array[i].point_X;
            let y = array[i].point_Y;
            const svgns = "http://www.w3.org/2000/svg";
            let text = document.createElementNS(svgns, "text");
            text.setAttribute("x", x);
            text.setAttribute("y", y);
            text.setAttribute("fill", "red");
            text.setAttribute("font-size", "28px");
            let id = "Caption" + caption_id;
            text.setAttribute("id", id);
            text.innerHTML = caption_id;
            svg.appendChild(text);
        }
    }
}

var xhrText = createXhrObject();
if (!xhrText) {
    window.alert("Objet XMLHTTPRequest non pris en charge par votre navigateur");
}

function printCaptionText(editable) {
    let category = document.getElementById("category-selection");
    let project = document.getElementById("project-selection");
    let language = document.getElementById("language-selection");
    language = language.options[language.selectedIndex].text;
    let value_cat = category.options[category.selectedIndex].text;
    let value_proj = project.options[project.selectedIndex].text;

    let url = "Controller/printCaptionText.php?title=" + value_proj + "&cat=" + value_cat + "&lang=" + language;
    xhrText.open("GET", url, false);
    xhrText.send(null);
    if (xhrText.status == 200) {
        let array = JSON.parse(xhrText.responseText);
        let field = document.getElementById("captions");
        field.innerHTML = "";
        let legend = document.createElement("legend");
        let legendText = document.createTextNode("Terminologies");
        legend.class = "w-auto";
        legend.appendChild(legendText);
        field.appendChild(legend);
        for (let i = 0; i < array.length; ++i) {
            let div = document.createElement("div");
            div.setAttribute("id", "captionDiv" + array[i].caption_id);
            let text = document.createElement("p");
            let nb = array[i].caption_id;
            let node = document.createTextNode(nb + " : ");
            text.appendChild(node);
            div.appendChild(text);


            
            let trad = array[i].text;
            node = document.createTextNode(" " + trad);
            let id = "Caption" + nb;
            let caption = document.getElementById(id);
            if (editable == '1') {
                text = document.createElement("input");  
                text.setAttribute("type", "text");    
                text.setAttribute("contenteditable", "true");
                text.onblur = function() {
                    changeText(text.value, nb);
                    caption.setAttribute("font-weight", "");
                };
            
                text.onfocus = function() {
                    caption.setAttribute("font-weight", "900");
                }
                text.setAttribute("value", trad);
            } else {
                text = document.createElement("p");
                text.appendChild(node);
            }
            div.appendChild(text);
            field.append(div);
        }
    }
}
