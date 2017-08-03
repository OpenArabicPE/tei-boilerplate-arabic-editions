function openNav() {
    styleWidth('navigation','300');
    styleRight('sidebar-buttons','300');
    document.getElementById("body").style.marginRight = "150px";
    document.getElementById("body").style.marginLeft = "-150px";
    styleVisibility('menuOpen','hidden');
    styleVisibility('menuClose','visible');
}

function closeNav() {
    styleWidth('navigation','0');
    styleRight('sidebar-buttons','0');
    document.getElementById("body").style.marginRight = "0px";
    document.getElementById("body").style.marginLeft = "0px";
    styleVisibility('menuOpen','visible');
    styleVisibility('menuClose','hidden');
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