$(document).on('ready, turbolinks:load', function(){
 console.log('ss')
  //Slot Selector
  var slot_selectors = [];
  var slot_selector_bar_matches = {};
  
  $('.slot-selector').each(function(elem){
    slot_selectors.push($(this))
    if(elem != 0) $(this).hide()
  })

  var slot_selector_links_counter = 0;
  $('.slot-selector .slot-selector--week-tabheader-link').each(function(){
    slot_selector_bar_matches[$(this).data('reactid')] = slot_selector_links_counter
    slot_selector_links_counter += 1
    if(slot_selector_links_counter > 2) slot_selector_links_counter = 0
  })

  $('.slot-selector--week-tabheader-link').on('click', function(){
    const current_slot_selector = slot_selector_bar_matches[$(this).data('reactid')];

    $('.slot-selector').each(function(elem){
      $(this).hide()
    })
    // console.log(current_slot_selector, slot_selectors[current_slot_selector])
    slot_selectors[current_slot_selector].show();
  })
  
  $('.available-slot--button').on('click', function(){
    var dateTimeString = $(this).find('.visually-hidden').text();
    var deliveryCostValue = $(this).find('.value').text()
    var deliveryCostCurrency = $(this).find('.currency').text()
    
    $('[name="delivery[deliver_on]"]').val(dateTimeString)
    $('[name="delivery[cost_value]"]').val(deliveryCostValue)
    $('[name="delivery[cost_currency]"]').val(deliveryCostCurrency)
    // console.log($('[name="delivery[deliver_on]"]'))
    // console.log(dateTimeString, deliveryCostValue, deliveryCostCurrency)
    $('.order-form').submit()
  })
});
