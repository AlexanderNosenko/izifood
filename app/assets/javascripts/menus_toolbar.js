//= require swiper/swiped

$(document).on('ready', function(){
  
  var s = Swiped.init({
    query: '.user-menu>.recipe',
    list: true,
    left: 100
  });

  // Bug with lib
  if(Array.isArray(s)) 
    s.forEach(function(elem){
      elem.close()
    });
  else if(s instanceof Swiped) 
    s.close()
  // $(".remove-recipe-btn a[data-remote]").on("ajax:success", function(e, data, status, xhr){
  //   // console.log(e, data, status, xhr)
  //   var s = Swiped.init({
  //     query: '.user-menu>.recipe',
  //     list: true,
  //     left: 100
  //   });
  //   console.log($(this))
  //   // console.log("Success", e.detail[0])
  // }).on("ajax:error", function(e, data, status, xhr){
  //   console.log("Error", e.detail[0])
  // })

$('.recipe').click();
  $(document).on('click', '.remove-recipe-btn', function(){
    $(this).closest('.recipe').fadeOut(300, function(){
      $(this).find('.remove-recipe-btn a').click();
      $(this).remove();
    });
  })

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
