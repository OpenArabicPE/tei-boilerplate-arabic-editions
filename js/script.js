// jQuery
$("document").ready(function() {
    // set variables for all functions
    var $buttonToggleLb = $("#toggleLb"),
    $buttonToggleSidebar = $("#toggleSidebar"),
    $body = $("#body"),
    $sidebar = $('.c_sidebar'),
    $navigation = $("#navigation"),
    $menuOpen = $("#menuOpen"),
    $menuClose = $("#menuClose");

// toggle the display of line beginnings (<lb/>) by toggling a class
$buttonToggleLb.on("click", function() {
    // toogle class of button
    $buttonToggleLb.toggleClass("c_toggled");
    // change the class of all line breaks to "c_toggled". The display is then set to "display:block" in CSS
    $("lb").toggleClass("c_toggled");
    // or change <lb> to <br>, but <br> has currently no styles associated in CSS
    // $("lb").replaceWith("<br></br>")
});

// toggle the display of the navigation panel by toggling a class
$buttonToggleSidebar.on("click", function() {
    // toggle class of button
    $buttonToggleSidebar.toggleClass("c_toggled");
    // try to set css on $body: invariably fails. Instead, everything can done through toggling classes and CSS
    // three elements must be moved: $body, $sidebar, the sidebar
    $body.toggleClass("c_sidebar-visible");
    $sidebar.toggleClass("c_sidebar-visible");
    // this could used to slide out something different from the navigation
    $navigation.toggleClass("c_sidebar-visible");
});
});