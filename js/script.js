// jQuery
$("document").ready(function() {
    // set variables for all functions
    var $buttonToggleLb = $("#toggleLb"),
    $buttonToggleNav = $("#toggleNav"),
    $buttonToggleSettings = $("#toggleSettings"),
    $body = $("#body"),
    $sidebar = $('.c_sidebar'),
    $navigation = $("#navigation"),
    $settings = $("#settings");

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
$buttonToggleNav.on("click", function() {
    // toggle class of button
    $buttonToggleNav.toggleClass("c_toggled");
    // try to set css on $body: invariably fails. Instead, everything can done through toggling classes and CSS
    // three elements must be moved: $body, $sidebar, the sidebar
    $body.toggleClass("c_sidebar-visible");
    $sidebar.toggleClass("c_sidebar-visible");
    $navigation.toggleClass("c_sidebar-visible");
});
// toggle the display of the navigation panel by toggling a class
$buttonToggleSettings.on("click", function() {
    // toggle class of button
    $buttonToggleSettings.toggleClass("c_toggled");
    // try to set css on $body: invariably fails. Instead, everything can done through toggling classes and CSS
    // three elements must be moved: $body, $sidebar, the sidebar
    // 1. check the current state of these elements
    if ($body.hasClass("c_sidebar-visible")) {

    } else {
        $body.toggleClass("c_sidebar-visible");
        $sidebar.toggleClass("c_sidebar-visible");
    };
    $settings.toggleClass("c_sidebar-visible");
});
});