//= require classie
//= require selectFx
//= require hoverForMore
//= require swiper/swiped

var load_count = 0
function init_ingredient_selectors(){
  Swiped.init({
    query: '.recipe-ingredients>.ingredient',
    list: true,
    left: 100,
    hackyCrap: true
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
  // TODO introduce react components
  $('.live-search-input').on('input', function(){

    var searchResultContainer = $(this).parent().find(".search-results");
    if($(this).val().length > 0){
      $(this).attr('data-active', true);
      searchResultContainer.show();
    }else{
      $(this).attr('data-active', false);
      searchResultContainer.hide();
    }

    $('.ingredient-search-form>input').val($(this).val())
    $('.ingredient-search-form').submit();
  })

  $(document).on('click', '.result-item', function(){
    if(!$(this).data('assigned')){
      var searchContainer = $('.live-search-input[data-active="true"]').closest('.ingredient-live-search');
      var ingredientContainer = searchContainer.closest('.ingredient');
      var ingredientTitle = ingredientContainer.find('.title');

      ingredientTitle.removeClass('disabled');
      searchContainer.find('.search-module').hide();

      var resultItemClone = $(this).clone();
      resultItemClone.attr('data-assigned', true);
      searchContainer.append(resultItemClone);

      var ingredientIdField = ingredientContainer.find('[data-prepended="true"]')

      if(ingredientIdField.length < 1){
        var ingredientIdField = $('<input>')
          .attr('name', 'order[order_items_attributes][][ingredient_id]')
          .attr('type','hidden')
          .attr('data-id', "")
          .attr('data-prepended', "true")
          .prependTo(ingredientContainer);
      }

      ingredientIdField.attr('value', $(this).data('id'))

      $('.live-search-input[data-active="true"]').val('');
      $('.live-search-input[data-active="true"]').trigger('input');

    }else{
      var container = $(this).parent().find('.search-module');

      container.show();
      container.find('.live-search-input').trigger('focus');

      container.closest('.ingredient').find('.title').addClass('disabled');
      container.closest('.ingredient').find('[data-prepended="true"]').attr('value', '');
      $(this).remove();
    }
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
