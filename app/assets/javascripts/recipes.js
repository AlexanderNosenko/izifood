//= require show_recipe

$(document).ready(function(){
  function animateAddingToMenuRecipe(elem){
    elem.animate({
      opacity: '.7',
    }, 300, function() {
      $(this).animate({
        opacity: '1',
      })
    });
  }

  function animateAddingToMenuNavigation(elem){
    elem.animate({
      backgroundColor: 'rgba(70, 184, 218, 0.5)',
      borderRadius: '5px',
      top: '20px',
      opacity: '.7',
    }, 300, function() {
      $(this).animate({
        backgroundColor: $('.navbar').css('backgroundColor'),
        top: '0px',
        opacity: '1',
        borderRadius: '0px',
      })
    });

    $('.navbar-toggle.collapsed').animate({
      backgroundColor: 'rgba(70, 184, 218, 0.5)',
      opacity: '.7',
    }, 300, function() {
      $(this).animate({
        backgroundColor: $('.navbar').css('backgroundColor'),
        opacity: '1',
      })
    });
  }
  
  function animateAddingToMenuBtn(elem){
    animatedElem = elem.parent().find('.add-to-menu-success-text')
    animatedElem.css('display', 'block');
    animatedElem.animate({
      top: '50%',
      opacity: '0',
    }, 700, function(){
      animatedElem.css('display', 'none');
      animatedElem.css('top', 'unset');
      animatedElem.css('opacity', '1');
    });
  }

  $(".add-to-menu-btn").on('click', function(){
    animateAddingToMenuRecipe($(this).closest('.recipe-content-overlay'))
    animateAddingToMenuNavigation($('#menus-nav-elem'))
    animateAddingToMenuBtn($(this))
  })

  $(".add-to-menu-btn> a[data-remote]").on("ajax:success", function(e, data, status, xhr){
    // console.log(e, data, status, xhr)
    // console.log("Success", e.detail[0])
  }).on("ajax:error", function(e, data, status, xhr){
    // console.log("Error", e.detail[0])
  })

  $(".remove-recipe-btn> a[data-remote]").on("ajax:success", function(e, data, status, xhr){
    // console.log(e, data, status, xhr)
    // console.log($(this))
    // console.log("Success", e.detail[0])
  }).on("ajax:error", function(e, data, status, xhr){
    // console.log("Error", e.detail[0])
  })
})