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
    // three elements must be moved: $body, $sidebar, the sidebar
    // check the current state of these elements
    if ($body.hasClass("c_sidebar-visible")) {
        // a side panel is already visible
        if ($navigation.hasClass("c_sidebar-visible")) {
            // if the settings panel is visible, everything should be closed
            $body.removeClass("c_sidebar-visible");
            $sidebar.removeClass("c_sidebar-visible");
            $navigation.removeClass("c_sidebar-visible");
        } else {
            // if the settings panel is visible, it should be replace with 
            // the navigation panel
            $settings.removeClass("c_sidebar-visible");
            $navigation.addClass("c_sidebar-visible");
            // the button to close the navigation panel should be untoggled
            $buttonToggleSettings.removeClass("c_toggled");
        };
    } else {
        // no side panel is visible
        $body.addClass("c_sidebar-visible");
        $sidebar.addClass("c_sidebar-visible");
        $navigation.addClass("c_sidebar-visible");
    };
});
// toggle the display of the navigation panel by toggling a class
$buttonToggleSettings.on("click", function() {
    // toggle class of button
    $buttonToggleSettings.toggleClass("c_toggled");
    // three elements must be moved: $body, $sidebar, the sidebar
    // check the current state of these elements
    if ($body.hasClass("c_sidebar-visible")) {
        // a side panel is already visible
        if ($settings.hasClass("c_sidebar-visible")) {
            // if the settings panel is visible, everything should be closed
            $body.removeClass("c_sidebar-visible");
            $sidebar.removeClass("c_sidebar-visible");
            $settings.removeClass("c_sidebar-visible");
        } else {
            // if the navigation panel is visible, it should be replace with 
            // the settings panel
            $navigation.removeClass("c_sidebar-visible");
            $settings.addClass("c_sidebar-visible");
            // the button to close the navigation panel should be untoggled
            $buttonToggleNav.removeClass("c_toggled");
        };
    } else {
        // no side panel is visible
        $body.addClass("c_sidebar-visible");
        $sidebar.addClass("c_sidebar-visible");
        $settings.addClass("c_sidebar-visible");
    };
});
});