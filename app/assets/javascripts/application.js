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
//turbolinks:load
$(document).on('ready', function(){
  $('#recipes-search-field').on('input', function(){
    $('#recipes-search-form').submit();
  })
})
