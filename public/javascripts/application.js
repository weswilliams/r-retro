// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function fireOnclick(objID) {
    var target = document.getElementById(objID);
    if (document.dispatchEvent) { // W3C
        var oEvent = document.createEvent("MouseEvents");
        oEvent.initMouseEvent("click", true, true, window, 1, 1, 1, 1, 1, false, false, false, false, 0, target);
        target.dispatchEvent(oEvent);
    }
    else if (document.fireEvent) { // IE
        target.fireEvent("onclick");
    }
}

jQuery(document).ready(function($) {

    $("a.collapse_link").click(function() {
        $("#" + this.id + "_span").slideToggle();
    });

    $("span.item_value").each(function() {
        var element_id = this.id;
        var window = new Window({className: "alphacube",  width:350, height:400, zIndex: 100, resizable: true, title: "r-retro", showEffect:Effect.BlindDown, hideEffect: Effect.SwitchOff, draggable:true, wiredDrag: true});
        $("#max_" + element_id).click(function() {
            var bg_color = $("#" + element_id).css('background-color');
            window.getContent().style.background = bg_color;
            window.getContent().innerHTML = "<p class='popup_text'>" + $("#" + element_id).html() + "</p>";
            window.showCenter();
        });
    });

    $("[data-submit='true']").change(function() {
        this.form.submit();
    });

    $("#enable_auto_refresh:checked").each(function() {
        $("[data-refresh]").each(function() {
            var refresh_url = $(this).attr('data-refresh');
            var refresh_interval = ($(this).attr('data-refresh-interval') || 20) * 1000;
            setInterval(function() {
                $.post(refresh_url);
            }, refresh_interval);
        });
    });

});
