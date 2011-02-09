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

var init_inline_edit = function initInlineEdit($) {
    $("[data-inline-edit]").each(function() {
        var editor_control_id = $(this).attr('data-inline-edit');
        var editor_url = $(this).attr('data-inline-edit-url');
        var editor_rows = $(this).attr('data-inline-edit-row') || 1;
        var editor_refresh_url = $(this).attr('data-inline-edit-refresh-url');
        var on_complete = function(transport) {
            if (editor_refresh_url) $.post(editor_refresh_url, function(data) {
                initInlineEdit($);
            });
        };
        var options = {
            externalControl: editor_control_id,
            highlightcolor: 'transparent',
            rows: editor_rows,
            cancelText: '(cancel)',
            okText: '(ok)',
            clickToEditText: 'double click to edit',
            onComplete: on_complete
        };
        var editor = new Ajax.InPlaceEditor(editor_control_id, editor_url, options);
        $("#" + editor_control_id).unbind('dblclick').dblclick(function() {
            editor.enterEditMode();
        });
        editor.dispose();
    });
};

var init_href_click = function($) {
    $("[data-href-click]").each(function() {
        var id_to_click = $(this).attr('data-href-click');
        $(this).unbind('click').click(function() {
            $('#' + id_to_click).click();
            return false;
        })
    });
};

var init_value_max_button = function($) {
    $("span.item_value").each(function() {
        var element_id = this.id;
        var window = new Window({className: "alphacube",  width:350, height:400, zIndex: 100, resizable: true, title: "r-retro", showEffect:Effect.BlindDown, hideEffect: Effect.SwitchOff, draggable:true, wiredDrag: true});
        $("#max_" + element_id).unbind('click').click(function() {
            var bg_color = $("#" + element_id).css('background-color');
            window.getContent().style.background = bg_color;
            window.getContent().innerHTML = "<p class='popup_text'>" + $("#" + element_id).html() + "</p>";
            window.showCenter();
            return false;
        });
    });
};

var init_collapsable = function($) {
    $("a.collapse_link").unbind('click').click(function() {
        $("#" + this.id + "_span").slideToggle();
        return false;
    });
};

var init_draggable = function($) {
    $("[data-draggable]").each(function() {
        $("#" + this.id).draggable({revert:true, revertDuration: 5, zIndex: 2700});
    });
};

var init_droppable = function($) {
    $("[data-droppable]").each(function() {
        var drop_url = $(this).attr('data-droppable');
        $("#" + this.id).droppable({
            drop: function(event, ui) {
                 $.post(drop_url, {"item_id": ui.draggable.attr('id') });
            }
        });
    });
};

var initJSActions = function($) {
    init_href_click($);
    init_inline_edit($);
    init_collapsable($);
    init_value_max_button($);
    init_draggable($);
    init_droppable($);
};

jQuery(document).ready(function($) {

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

    initJSActions($);

});
