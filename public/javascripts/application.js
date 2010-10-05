// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function fireOnclick(objID) {
var target=document.getElementById(objID);
if(document.dispatchEvent) { // W3C
    var oEvent = document.createEvent( "MouseEvents" );
    oEvent.initMouseEvent("click", true, true,window, 1, 1, 1, 1, 1, false, false, false, false, 0, target);
    target.dispatchEvent( oEvent );
    }
else if(document.fireEvent) { // IE
    target.fireEvent("onclick");
    }
}
