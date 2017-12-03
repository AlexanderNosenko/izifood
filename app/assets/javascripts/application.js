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
var event = new Event('shit_test');

$(document).on('ready', function(){
  function searchRecipes(){
    if($('#recipes-search-field').val().length > 0){
      $('.search-icon').removeClass('active');
      $('#reset-search').addClass('active');
    }else{
      $('.search-icon').removeClass('active');
      $('.glass').addClass('active');
    }
    
    // var location = window.location.href;
    // if(!location.includes('?')) location = location + "?"

    // var queryParam = "&q=" + $('#recipes-search-field').val();

    // if(location.match(/&q=\w*/))
    //   var new_location = location.replace(/&q=\w*/, queryParam); 
    // else
    //   var new_location = location + queryParam

    // window.history.pushState('page2', 'Title', new_location);
    // $('#recipes-search-form').submit();
  }


  $('#recipes-search-field').on('input', function(){
    searchRecipes()
  })
  $('#recipes-search-form>.btn').on('click', function(){
    searchRecipes()
  })

  $('#reset-search').on('click', function(){
    $('#recipes-search-field').val('')
    searchRecipes()
    $('#recipes-search-form').submit();
  });

  $('.more-categories-btn').on('click', function(){
    var wrapper = $('.recipe-filters__categories');
    var content = $(this).find('.recipe-filters__categories__category-filter__content');
    
    if( wrapper.hasClass('full-height') ){
      wrapper.removeClass('full-height')
    }else{
      wrapper.addClass('full-height')
    }
    
    if( wrapper.hasClass('full-height') ){
      content.text('Less')
    }else{
      content.text('More')
    }
  })
})
