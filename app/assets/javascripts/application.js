//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
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