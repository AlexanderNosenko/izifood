$(document).on('ready', function(){
  $('.menu-togle-btn').on('click', function(){
    var menu_id = $(this).data('id');

    // Toggle toolbar
    $('.menu-togle-btn').removeClass('btn-info');
    $('.menu-togle-btn[data-id="' + menu_id + '"]').addClass('btn-info');

    // Toggle menus
    $('.menu-block').hide();
    $('.menu-block[data-id="' + menu_id + '"]').show();
    
    $.ajax({
      method: "PATCH",
      url: "/menus/" + menu_id,
      data: { main: true }
    }).done(function( msg ) {
        // console.log( "Data Saved: " + msg );
      });
  })  
})
