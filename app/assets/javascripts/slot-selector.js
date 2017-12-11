function defineSlotGrid(){
  var slotsGrid = [];

  $('.slot-grid__table').each(function(i){
    slotsGrid[i] = []
    $(this).find('tbody>tr').each(function(j){
      slotsGrid[i][j] = []
      $(this).find('.slot-grid--item').each(function(k){
        slotsGrid[i][j][k] = {
          status: !$(this).hasClass('unavailable'),
          button: $(this)
        }
      })
    })
  })

  return slotsGrid;  
}

function transposeMatrix(matrix){
  return matrix[0].map(function(col, i){ return matrix.map(function(row){return row[i]}) });
}

function getSlotSelectors(){
  var slot_selectors = [];

  $('.slot-selector').each(function(elem){
    slot_selectors.push($(this))
    if(elem != 0) $(this).hide()
  })
  
  return slot_selectors;
}

function getSlotSelectorBtns(){
  var slot_selector_links_counter = 0, slot_selector_bar_matches = {};

  $('.slot-selector .slot-selector--week-tabheader-link').each(function(){
    slot_selector_bar_matches[$(this).data('reactid')] = slot_selector_links_counter
    slot_selector_links_counter += 1
    if(slot_selector_links_counter > 2) slot_selector_links_counter = 0
  })

  return slot_selector_bar_matches;
}

function changeSlotWeek(target){
  //Slot Selector
  var slot_selectors = getSlotSelectors();
  var slot_selector_bar_matches = getSlotSelectorBtns();
  var current_slot_selector = slot_selector_bar_matches[target.data('reactid')];

  $('.slot-selector').each(function(elem){ $(this).hide()})
  // console.log(slot_selectors, current_slot_selector)
  if(slot_selectors[current_slot_selector])
    slot_selectors[current_slot_selector].show();
}

function selectDay(target){
  if(!target) return //To avoid errors
  // Slots grid
  var slotsGrid = [], slotsGridTransposed = [];
  slotsGrid = defineSlotGrid();
  // console.log(slotsGrid)
  if (slotsGrid.length > 0)
    for(i=0;i<slotsGrid.length;i++)
      slotsGridTransposed[i] = transposeMatrix(slotsGrid[i])
  // console.log(slotsGridTransposed)

  var elem = target.closest('.day-selector__list-item');
  $('.day-selector__list-item').removeClass('day-selector__list-item--selected');
  elem.addClass('day-selector__list-item--selected');
  var date = elem.data('date');

  // Run through all SlotLists and copy every btn form to approproate mobile layout slot
  target.closest('.slot-selector--single-week').find('.day-selector__list-item').each(function(index){
    if($(this).data('date') == date){
      $('.slot-list').each(function(slotListIndex){
        $(this).find('li').each(function(timeIndex){
          $(this).removeClass('available')
          $(this).removeClass('unavailable')
          
          var status = slotsGridTransposed[slotListIndex][index][timeIndex].status;
          var button = slotsGridTransposed[slotListIndex][index][timeIndex].button;
          var slotClass = status ? 'available' : 'unavailable';
          
          $(this).addClass(slotClass)

          if(status)
            $(this).find('.status').html(button.clone())
          else
            $(this).find('.status').html('<span class="unavailable-slot-text" data-reactid="336"><span data-reactid="338">Unavailable</span></span>')
        })
      })
    }
  })

}

$(document).on('ready', function(){
  $('.slot-selector--week-tabheader-link').on('click', function(){
    changeSlotWeek($(this))
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
  

  
  // Toggle dayly slots for MOBILE layout
  $('.day-selector__day-date').on('click', function(){
    selectDay($(this))
  })
});
