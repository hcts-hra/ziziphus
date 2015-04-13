var autocompletes = [];

jQuery(document).ready(function () {
    // init jquery layout
    ziziphusLayout = $('body').layout({
        defaults: {
            applyDefaultStyles: true,
            enableCursorHotkey: false
        },
        north: {
            applyDefaultStyles: false,
            resizable: true,
            closable: false,
            spacing_open: 0,
            size: 40,
            minSize: 0
        },
        west: {
            resizable: true,
            closable: true,
            size: '33%',
            minSize: 250
        },
        east: {
            resizable: true,
            closable: true,
            size: '33%',
            minSize: 250
        },
        south: {
            resizable: false,
            closable: true,
            spacing_open: 0,
            spacing_closed: 6
        }
    });
    leftCenter();
    // end: init jquery layout


    var w = $.jWindow({
        parentElement: '#heidiconWindow',
        id: 'heidiconData',
        title: 'Heidicon Data',
        posx: 200,
        posy: 100,
        width: 600,
        height: 500,
        type: 'ajax',
        refreshButton: false});


    jQuery('#heidicon').on({
        click: function () {
            var myUrl = 'modules/showHeidicon.xql?id=' + $('#heidiconWindow').attr('current');
            w.set({url: myUrl});
            w.show();
            w.update();
            return false;
        }
    });

    var versionsw = $.jWindow({
        parentElement: '#versionsWindow',
        id: 'versions',
        title: 'Versions History',
        posx: 200,
        posy: 100,
        width: 800,
        height: 600,
        type: 'ajax',
        refreshButton: false});


    jQuery('#work-versions-button').on({
        click: function () {
            var myUrl = 'modules/versions.xql?ajax=yes\u0026workdir=' + $('#workdir .xfValue').val() + '\u0026rid=' + $('#work-versions-button').attr('subject');
            versionsw.set({url: myUrl});
            versionsw.set({title: 'Work Versions History'});
            versionsw.show();
            versionsw.update();
            return false;
        }
    });

    jQuery('#image-versions-button').on({
        click: function () {
            var myUrl = 'modules/versions.xql?ajax=yes\u0026workdir=' + $('#workdir .xfValue').val() + '\u0026iid=' + $('#image-versions-button').attr('subject');
            versionsw.set({url: myUrl});
            versionsw.set({title: 'Image Versions History'});
            versionsw.show();
            versionsw.update();
            return false;
        }
    });

    jQuery('#report-issue').on("click", function (e) {
        console.log("fired 'report issue'",e);
        var uuid = getParameter("id");
        console.log("uuid: ",uuid);
//        $('#issue-window').html("<iframe src='resources/components/issue-tracker.html?uuid=" + encodeURIComponent(uuid) + "' />");
        $("<iframe id='issues-frame'></iframe>")
                            .attr("src","resources/components/issue-tracker.html?uuid=" + encodeURIComponent(uuid) + ")")
                            .attr("style","position:fixed;top:0;width:100%;background:white;z-index:10")
                            .addClass("animated")
                            .addClass("slideInDown")
                            .appendTo("#issue-window");


    });
    
    initTextExpand();
}).tooltip({
  items:'i[title]',
  content: function() {
      var element = $(this);
      var tooltip = element.attr( "title" );
      return tooltip;
  }
});



dojo.addOnLoad(function () {
    dojo.addOnLoad(function () {
        // console.debug("onload");
        require(["dojo/dom", "dojo/dom-style"], function (dom, domStyle) {
            var overlay = dom.byId("overlay");
            if (overlay) {
                var animation = dojo.fadeOut({node: overlay, duration: 1000});
                dojo.connect(animation, "onEnd", function () {
                    console.debug("hide overlay");
                    domStyle.set(overlay, "display", "none");

                });
                animation.play();
            } else {
                console.debug("no overlay present");
            }
        });
    });
});

function toggleDetail(n, m) {
    console.debug("this: n:", n, " m:", m);
    $(n).toggleClass("button-zoom-out");
    $(n).toggleClass("button-zoom-in");
    $("#" + m).toggleClass("simple");
    $("#" + m).toggleClass("full");
}
function showWindow() {
    w.show();
}

// request to close the form and switch back to view
function closeForm() {
    var doIt = confirm("There are unsaved changes - Really close?");
    if (doIt == false) {
        return;
    }
    $('#close-value').click();
}

function editOtherForm(id) {
    var doIt = confirm("There are unsaved changes in the current section - Do you want to discard the changes?");
    if (doIt == false) {
        return;
    }
    fluxProcessor.dispatchEventType(id, 'load-form');
}

// triggers deleltion of selected repeat entry
function removeEntry() {
    var doIt = confirm("Really delete this entry?");
    if (doIt == false) {
        return;
    }
    $('#doDelete-value').click();
}

function deleteRecord() {
    var doIt = confirm("Really delete this workrecord and related imagerecords?");
    if (doIt == false) {
        return;
    }
    $('#t-delete-workrecord-value').click();
}

function openWorkrecordInTamboti() {
    var url = '/exist/apps/tamboti/modules/search/index.html?search-field=ID&value=' + $('#workrecordid-value').val();
    window.open(url, '_blank');
}

function leftCenter() {
    ziziphusLayout.open('west');
    ziziphusLayout.close('east');
    ziziphusLayout.sizePane("west", "50%");
}
function allCols() {
    ziziphusLayout.open("west");
    ziziphusLayout.sizePane("west", "33%");
    ziziphusLayout.open("east");
    ziziphusLayout.sizePane("east", "33%");
}
function centerRight() {
    ziziphusLayout.close('west');
    ziziphusLayout.open('east');
    ziziphusLayout.sizePane("east", "50%");
}
function toggleSetVisibility(side) {
    console.debug("Side " + side);
    $("#" + side).toggleClass("forceVisible");
    $('#' + side + 'Separator')[0].scrollIntoView();
    var inner = $("#" + side + " .separator").html();
    if (inner == "more VRA Sets...") {
        $("#" + side + " .separator").html("less VRA Sets...");
    } else {
        $("#" + side + " .separator").html("more VRA Sets...");
    }
}
function scrollToPanel(id) {
    $('#' + id + ' .dijitTitlePaneTitle').effect("highlight", {color: 'lightsteelblue'}, 1500);
    $('#' + id)[0].scrollIntoView();
}
function showWorkXML() {
    $('#t-load-xml-value').click();
}
function showImageXML() {
    $('#t-load-xml-image-value').click();
}

function getParameter(paramName) {
    var searchString = window.location.search.substring(1),
            i, val, params = searchString.split("&amp;");
    for(i in params){
        val = params[i].split("=");
        if (val[0] == paramName) {
            return unescape(val[1]);
        }
    }
    return null;
}



