//= require jquery
//= require jquery_ujs
//= require selectize
//= require moment
//= require datetime_picker
//= require_tree .
//= require classie
//= require selectFx
  $(document).on('ready', function(){
    $('select.cs-select').each(function(){
      new SelectFx($(this)[0]); 
    })
    
    // Javascript
    // $(".overflowing").hoverForMore({
    //   speed: 80.0,    // Measured in pixels-per-second
    //   loop: false,    // Scroll to the end and stop, or loop continuously?
    //   gap: 20,    // When looping, insert this many pixels of blank space
    //   target: false,    // Hover on this CSS selector instead of the text line itself
    //   removeTitle: false, // By default, remove the title attribute, as a tooltip is redundant
    //   snapback: true,   // Animate when de-activating, as opposed to instantly reverting
    //   alwaysOn: false,  // If you're insane, you can turn this into a <marquee> tag. (Please don't.)

    //   // In case you want to alter the events which activate and de-activate the effect:
    //   startEvent: "mouseenter",
    //   stopEvent: "mouseleave"
    // });
  });
