$(function() {
    
    
    var scrollPane = $(".scroll-pane");
    var scrollContent = $(".scroll-content");

    var scrollbar = $(".scroll-bar").slider({
        slide: function(event, ui) {
            if (scrollContent.width() > scrollPane.width()) {
                scrollContent.css("margin-left", Math.round(
                        ui.value / 100 * (scrollPane.width() - scrollContent.width())
                        ) + "px");
            } else {
                scrollContent.css("margin-left", 0);
            }
        }
    });

    var handleHelper = scrollbar.find(".ui-slider-handle")
            .mousedown(function() {
                scrollbar.width(handleHelper.width());
            })
            .mouseup(function() {
                scrollbar.width("100%");
            })
            .append("<span class='ui-icon ui-icon-grip-dotted-vertical'></span>")
            .wrap("<div class='ui-handle-helper-parent'></div>").parent();
    scrollPane.css("overflow", "hidden");

    function sizeScrollbar() {
        var remainder = scrollContent.width() - scrollPane.width();
        var proportion = remainder / scrollContent.width();
        var handleSize = scrollPane.width() - (proportion * scrollPane.width());
        scrollbar.find(".ui-slider-handle").css({
            width: handleSize,
            "margin-left": -handleSize / 2
        });
        handleHelper.width("").width(scrollbar.width() - handleSize);
    }

    function resetValue() {
        var remainder = scrollPane.width() - scrollContent.width();
        var leftVal = scrollContent.css("margin-left") === "auto" ? 0 :
                parseInt(scrollContent.css("margin-left"));
        var percentage = Math.round(leftVal / remainder * 100);
        scrollbar.slider("value", percentage);
    }

    function reflowContent() {
        var showing = scrollContent.width() + parseInt(scrollContent.css("margin-left"), 10);
        var gap = scrollPane.width() - showing;
        if (gap > 0) {
            scrollContent.css("margin-left", parseInt(scrollContent.css("margin-left"), 10) + gap);
        }
    }

    $(window).resize(function() {
        resetValue();
        sizeScrollbar();
        reflowContent();
    });

    setTimeout(sizeScrollbar, 10);//safari wants a timeout
    
    
    $("body").layout({
        defaults: {
            applyDefaultStyles: true,
            enableCursorHotkey: false
        },
        south: {
            resizable: false,
            closable: false,
            spacing_open: 6,
            spacing_closed: 0,
            size: '136px'
        }
    });
});

function loadRecord(uuid, collection) {
    $("#iEditor").attr("src", "/exist/apps/ziziphus/record.html?id=" + uuid + "&workdir=" + collection);
}


