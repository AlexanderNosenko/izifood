//= require location_picker
//= require slot-selector

function prepareSlotSelectors(){
  var tabLink = $('.slot-selector:first').find('.slot-selector--week-tabheader-link:first');
  changeSlotWeek(tabLink)
  selectDay()
}

function handleLoading(check_url){
  setInterval(function(){
    $.get( check_url, function( status ) {
      if(status == 'complete') window.location.reload()      
    });
  }, 1000)
}

function getSelectedSlot(data){
  var day = new Date(data.deliver_on).getDate()
  day = day > 9 ? day : "\\s" + day

  var delivery_date = new RegExp(day + "(\\w|\\s|,)*" + data.time_from + " - ")
  
  var result = null

  $('.slot-grid--item .visually-hidden').each(function(){
    // console.log($(this).text(), delivery_date)
    if($(this).text().match(delivery_date)){
      var tabLink = $(this).closest('.slot-selector').find('.tabheader.active>.slot-selector--week-tabheader-link');
      changeSlotWeek(tabLink)

      var elem = $(this).parent()
      result = elem.is( ":button" ) ? elem : elem.parent()
      return
    }
  })

  return result
}

function getSelectedDay(data){
  var result = null
  
  $('.day-selector__list-item').each(function(){
    // console.log($(this).data('date'), data.deliver_on)
    if($(this).data('date') == data.deliver_on){
      result = $(this)
      return
    }
  })
  return result;
}

function setSlot(data){
  if($('.slot-selector').length > 0){
    var slot = getSelectedSlot(data)
    var slotDay = getSelectedDay(data)

    $(slot).addClass('slot-selected')
    selectDay(slotDay)
  }
}