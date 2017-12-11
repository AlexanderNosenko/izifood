//= require classie
//= require selectFx
//= require hoverForMore
//= require swiper/swiped

var load_count = 0
function init_ingredient_selectors(){
  Swiped.init({
    query: '.recipe-ingredients>.ingredient',
    list: true,
    left: 100
  });

  // Ingredient Selector
  if(load_count == 0)
    $('select.cs-select').each(function(){
      new SelectFx($(this)[0]); 
    })
  load_count = 1
}

$(document).on('ready', function(){
  // Order Items managment
  $(document).on('click', '.remove-order-item-btn', function(){

    var prevElem = $(this).parent().prev();
    if(prevElem.hasClass('alert'))
      prevElem.fadeOut(400, function(){
        $(this).remove()
      })

    $(this).parent().fadeOut(400, function(){
      $(this).remove()
    })
  })

  //Live search
  $('.live-search-input').on('input', function(){
    $(this).closest('form').submit();
  })

  $(document).on('click', '.search-results>.ingredient', function(){
    var ingredient_clone = $('.recipe-ingredients>.ingredient:first')

    $(this).clone().appendTo('.custom-ingredients');

  })
  init_ingredient_selectors()
  
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
