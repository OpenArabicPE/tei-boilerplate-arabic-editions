// assign a variable to the search button
var theButton =document.getElementById('b_toggle');
console.log(theButton);

function toggleLineBeginnings() {
	// check if the button was clicked
	console.log("You pressed me?")
	// generate a variable holding <br/> elements
	var theBreaks = document.getElementsByTagName('lb');
	// console.log(theBreaks)
	theBreaks.innerHTML = "hello world!";
	console.log(theBreaks)
}

// do something upon clicking the button
//theButton.addEventListener('click',toggleLineBeginnings);

function insertHTML_ByXPath( xpath, position, newElement) {
    var element = document.evaluate(xpath, window.document, null, 9, null ).singleNodeValue;
    element.insertAdjacentHTML(position, newElement);
    // element.style='border:3px solid orange';
}

var xpath_DOMElement = '//*[@id="answer-33669996"]/table/tbody/tr[1]/td[2]/div';
var childHTML = '<div id="Yash">Hi My name is <B>\"YASHWANTH\"</B></div>';
var position = 'beforeend';

// insertHTML_ByXPath(xpath_DOMElement, position, childHTML);

// do something upon clicking the button
// theButton.addEventListener('click',insertHTML_ByXPath('//lb[1]',position,'<span>hello world</span>'))

function addCSS(tag) {
    window.document.getElementsByTagName(tag)[1].style.cssText += "display: block;";
}
//theButton.addEventListener('click',addCSS('lb'));

function addElement(tag, addedElement, style, innerHTML){
    var elemDiv = document.createElement(addedElement);
    // elemDiv.style.cssText = style;
    elemDiv.style.cssText = 'width:100%;height:10%;background:rgb(192,192,192);';
    elemDiv.innerHTML = innerHTML; 
    window.document.body.insertBefore(elemDiv, window.document.body.getElementsByTagName(tag));
    // document.body.appendChild(elemDiv); // appends last of that element
}

//theButton.addEventListener('click',addElement('lb','span','display:block;','test'))


// jQuery
$("document").ready(function() {
    // set variables for all functions
    var $buttonToggleLb = $("#b_toggle-lb"),
        $buttonToggleSidebar = $("#b_toggle-sidebar"),
        $body = $("#body");

// Event setup using a convenience method

// 1. every button should get the "c_toggled" class upon being toggled
// $("button").on("click", function(){
//     var id = $("button").attr('id');
//     console.log(id);
//     // this is currently not working since all or no button are assigned the new class
//     // $(id).toggleClass("c_toggled");
//     // the following is for debugging only check class of button 
//     // if ($("button").is(".c_toggled")) {
//     //     // if button is toggled do some thing
//     //     console.log(id += " toggled on");
//     // }
//     // else {
//     //     // revert to original state
//     //     console.log(id += " toggled off");
//     // }
// });

// 2. use a specific button to change the class of another element, which is then styled with CSS
$buttonToggleLb.on("click", function() {
    // toogle class of button
    $buttonToggleLb.toggleClass("c_toggled");
    // change the class of all line breaks to "c_toggled". The display is then set to "display:block" in CSS
    $("lb").toggleClass("c_toggled");
    // or change <lb> to <br>, but <br> has currently no styles associated in CSS
    // $("lb").replaceWith("<br></br>")
});

// jQuery for sliding panel 
$buttonToggleSidebar.on("click", function() {
    // toggle class of button
    $buttonToggleSidebar.toggleClass("c_toggled");
    // debugging
    // test if state of button 
    if ($buttonToggleSidebar.is(".c_toggled")) {
        console.log("on"); 
        // debugging: this works
            // $body.addClass("toggle-is-true");
            // console.log($body.attr("class"));
        // if button is toggled open the sidebar
        // try to set css on $body: invariably fails
        // $("#sidebar-buttons").css("right", widthSidebar);
        $body.css({
            "margin-right": "300px",
            "margin-left": "-300px"
        });  
    }
    else {
        console.log("off");
        // revert to original state   
        $("#body").addClass("toggle-is-false");
    }

});
});