
function toggleView(control,target){
    // console.debug("toggleView: control:", control, " ,target:",target);
    if(target == "twoColumnMode" && control.checked){
        var width = dojo.style("mainpanel","width");
        var containerSize = (width / 2) - 20;
        dojo.style(dojo.byId("workrecord"), "width", (containerSize +"px"));
        dojo.style(dojo.byId("imagerecord"), "width", (containerSize +"px"));
        dijit.byId("mainpanel").layout();
    } else if(target == "twoColumnMode" && !control.checked) {
        dojo.style(dojo.byId("workrecord"), "width", "20%");
        dojo.style(dojo.byId("imagerecord"), "width", "20%");
        dijit.byId("mainpanel").layout();
    }else {
        if(control.checked){
            dijit.byId("mainpanel").addChild(dijit.byId(target));
        }else{
            dijit.byId("mainpanel").removeChild(dijit.byId(target));
        }
    }
}
function collapse(control,target){
    console.debug("collapse: control:", control, " ,target:",target);
    var open = control.checked;
    var node;
    if(target == "work") {
        node = dojo.byId("workrecord");
    }
    else if(target == "image"){
        node = dojo.byId("imagerecord");
    }else {
        node = dojo.body();
    }
    if(target != "all" && !open){
        dijit.byId("collapseAll").set("checked",false);
    }
    if(target == "all" && open){
        dijit.byId("collapseWork").set("checked",true);
        dijit.byId("collapseImage").set("checked",true);
    }
    dojo.query(".dijitTitlePane",node).forEach(function(item){
        dijit.byId(item.id)._setOpenAttr(open,true);
    });
    if(dijit.byId("collapseWork").get("checked") && dijit.byId("collapseImage").get("checked")){
        dijit.byId("collapseAll").set("checked",true);
    }
}
