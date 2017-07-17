function openNav() {
    document.getElementById("navigation").style.width = "300px";
    document.getElementById("sidebar-buttons").style.right = "300px";
    document.getElementById("menuOpen").className = "c_hidden";
    document.getElementById("menuClose").className = "c_visible";
}

function closeNav() {
    document.getElementById("navigation").style.width = "0";
    document.getElementById("sidebar-buttons").style.right = "0";
    document.getElementById("menuClose").className = "c_hidden";
    document.getElementById("menuOpen").className = "c_visible";
}