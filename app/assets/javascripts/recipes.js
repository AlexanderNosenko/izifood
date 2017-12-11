//= require show_recipe
//= require recipe_filters

$(document).ready(function(){
  function animateAddingToMenuStatus(elem){
    elem.addClass('show')
    animateElement(elem, 'add-to-menu-success-text--animated', 300)
    setTimeout(function(){elem.removeClass('show')}, 300)
  }

  $(".add-to-menu-btn").on('click', function(){
    animateElement($(this).closest('.recipe-content-overlay'), 'recipe-content-overlay--animated', 300)
    animateAddingToMenuStatus($(this).parent().parent().find('.add-to-menu-success-text'))
    animateElement($('.menus-nav-elem'), 'menus-nav-elem--animated', 300)
    animateElement($('.navbar-toggle.collapsed'), 'collapsed--animated', 300)
    
    // animateAddingToMenuRecipe($(this).closest('.recipe-content-overlay'))
    // animateAddingToMenuNavigation()
    // animateAddingToMenuBtn($(this).parent().find('.add-to-menu-success-text'))
  })

  $(".add-to-menu-btn> a[data-remote]").on("ajax:success", function(e, data, status, xhr){
    // console.log(e, data, status, xhr)
    // console.log("Success", e.detail[0])
  }).on("ajax:error", function(e, data, status, xhr){
    // console.log("Error", e.detail[0])
  })

})