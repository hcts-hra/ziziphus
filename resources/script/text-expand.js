/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var animspeed = 950;

function initTextExpand() {
    jQuery('div[data-expand]').each( function(index) {
        $this = $(this);
        $this.css('height',$this.attr('data-collapse'));
    });
    
    //Remove click-handler
    jQuery('.expand').off('click');
    jQuery('.contract').off('click');
    
    //Add click-handler
    jQuery('.expand').on('click', function(e){
        $text = $(this).prev('div[data-expand]');

        $text.animate({
          'height': $text.attr('data-expand')
        }, animspeed);
        $(this).next('.contract').removeClass('hide');
        $(this).addClass('hide');
    });
 
    jQuery('.contract').on('click', function(e){
        $text = $(this).prev('.expand').prev('div[data-expand]');

        $text.animate({
          'height': $text.attr('data-collapse')
        }, animspeed);
        $(this).prev('.expand').removeClass('hide');
        $(this).addClass('hide');
    });
}