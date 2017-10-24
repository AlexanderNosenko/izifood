// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets

$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});
$(document).on('ready, turbolinks:load', function(){
  $('.menu-togle-btn').on('click', function(){
    $('.menu-block').hide();
    var menu_id = $(this).data('id');

    // ('[data-id="' + menu_id + '"]')
    $('.menu-block[data-id="' + menu_id + '"]').show();
    
    $.ajax({
      method: "PATCH",
      url: "/menus/" + menu_id,
      data: { main: true }
    }).done(function( msg ) {
        console.log( "Data Saved: " + msg );
      });
  })
  setTimeout(function(){
    $(".alert.alert-dismissable").fadeTo(500, 0);  
  }, 5000)
})
