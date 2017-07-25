// assign a variable to the search button
var theButton =document.getElementById('b_toggle');
console.log(theButton);

function toggleLineBeginnings() {
	// check if the button was clicked
	console.log("You pressed me?")
	// generate a variable holding <br/> elements
	var theBreaks = document.getElementsByTagName('lb');
	console.log(theBreaks)
	theBreaks.innerHTML = "<br />"
}

// do something upon clicking the button
theButton.addEventListener('click',toggleLineBeginnings);