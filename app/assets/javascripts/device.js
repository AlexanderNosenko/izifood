//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets

$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});