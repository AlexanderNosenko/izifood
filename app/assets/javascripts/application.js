//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require toastr
//= require menus_toolbar

$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});

function animateElement(elem, _class, time){
  setTimeout(function(){elem.addClass(_class)})
  setTimeout(function(){elem.removeClass(_class)}, time);
}

if(localStorage.getItem("orderGuideDone") != "true"){
  var xDown = null;

  $(document).on('touchstart', '.swipe-guide-overlay', function(e){
    xDown = e.originalEvent.touches[0].clientX;
  })

  $(document).on('touchmove', '.swipe-guide-overlay', function(e){
    if ( ! xDown ) return;

    var xUp = e.originalEvent.touches[0].clientX;
    var xDiff = xDown - xUp;

    console.log(xDiff)
    if ( xDiff <= -14 ) {

      setTimeout(function() {
        localStorage.setItem("orderGuideDone", true);
        $('.swipe-guide-overlay').fadeOut()
      }, 400)

    }

    xDown = null;
  })
}else{
  $(document).ready(function(){ $('.swipe-guide-overlay').remove() })
}

if(localStorage.getItem("menuGuideDone") != "true"){
  var xDown = null;

  $(document).on('touchstart', '.menu-swipe-guide-overlay', function(e){
    xDown = e.originalEvent.touches[0].clientX;
  })

  $(document).on('touchmove', '.menu-swipe-guide-overlay', function(e){
    if ( ! xDown ) return;

    var xUp = e.originalEvent.touches[0].clientX;
    var xDiff = xDown - xUp;

    console.log(xDiff)
    if ( xDiff <= -14 ) {

      setTimeout(function() {
        localStorage.setItem("menuGuideDone", true);
        $('.menu-swipe-guide-overlay').fadeOut()
      }, 400)

    }

    xDown = null;
  })
}else{
  $(document).ready(function(){ $('.menu-swipe-guide-overlay').remove() })
}
