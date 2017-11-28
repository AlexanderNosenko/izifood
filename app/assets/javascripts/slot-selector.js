$(document).on('ready', function(){
  
  // Slots grid
  var slotsGrid = [], slotsGridTransposed = [];

  $('.slot-grid__table:first>tbody>tr').each(function(i){
    slotsGrid[i] = []
    $(this).find('.slot-grid--item').each(function(j){
      slotsGrid[i][j] = {
        status: !$(this).hasClass('unavailable'),
        button: $(this)
      }
    })    
  })
  // console.log(slotsGrid)
  if (slotsGrid.length > 0)
    slotsGridTransposed = slotsGrid[0].map(function(col, i){ return slotsGrid.map(function(row){return row[i]}) });
  // console.log(slotsGridTransposed)


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
  
  $(document).on('click', '.available-slot--button', function(){
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
  


  // Toggle slots MOBILE
  $('.day-selector__day-date').on('click', function(){
    var date = $(this).closest('.day-selector__list-item').data('date')
    
    $(this).closest('.slot-selector--single-week').find('.day-selector__list-item').each(function(index){
      if($(this).data('date') == date){
        $('.slot-list:first').find('li').each(function(timeIndex){
          $(this).removeClass('available')
          $(this).removeClass('unavailable')
          
          var status = slotsGridTransposed[index][timeIndex].status;
          var button = slotsGridTransposed[index][timeIndex].button;
          var slotClass = status ? 'available' : 'unavailable';
          
          $(this).addClass(slotClass)

          if(status)
            $(this).find('.status').html(button.clone())
          else
            $(this).find('.status').html('<span class="unavailable-slot-text" data-reactid="336"><span data-reactid="338">Unavailable</span></span>')
        })
      }
    })
  })
});
