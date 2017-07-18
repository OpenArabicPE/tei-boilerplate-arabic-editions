function openNav() {
    styleWidth('navigation','300');
    styleRight('sidebar-buttons','300');
    document.getElementById("body").style.marginRight = "300px";
    document.getElementById("body").style.marginLeft = "-300px";
    styleVisibility('menuOpen','hidden');
    styleVisibility('menuClose','visible');
    // document.getElementById("menuOpen").style.visibility = "hidden";
    // document.getElementById("menuClose").style.visibility = "visible";
}

function closeNav() {
    styleWidth('navigation','0');
    styleRight('sidebar-buttons','0');
    document.getElementById("body").style.marginRight = "0px";
    document.getElementById("body").style.marginLeft = "0px";
    styleVisibility('menuOpen','visible');
    styleVisibility('menuClose','hidden');
    // document.getElementById("menuClose").style.visibility = "hidden";
    // document.getElementById("menuOpen").style.visibility = "visible";
}

// set the width of an element by ID
function styleWidth(tag,pixels) {
	document.getElementById(tag).style.width = pixels + "px";
}
function styleRight(tag,pixels) {
	document.getElementById(tag).style.right = pixels + "px";
}
function styleVisibility(tag,value) {
	document.getElementById(tag).style.visibility = value;
}