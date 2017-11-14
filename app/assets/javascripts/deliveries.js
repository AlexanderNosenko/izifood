//= require location_picker
//= require slot-selector
function getDots(i){
  switch(i){
    case 1:
      return '.'
    break;
    case 2:
      return '..'
    break;
    case 3:
      return '...'          
    break;
    default:
      return '';
    break;
  }
}

var i = 0;
function showLoadingAnimation(i){      
  dots = getDots(i);
  $('.loading>span').text(dots);
}

function handleLoading(check_url){
  setInterval(function(){
    $.get( check_url, function( status ) {
      if(status == 'complete')
        window.location.reload()
      else
        showLoadingAnimation(i)
    });
    i++;
    if (i > 3) i = 1;
  }, 1000)
}

function getSelectedSlot(data){
  day = new Date(data.deliver_on).getDate()
  day = day > 9 ? day : "\\s" + day

  delivery_date = new RegExp(day + ".*" + data.time_from + " - ")
  
  result = null

  $('.slot-grid--item .visually-hidden').each(function(){
    if($(this).text().match(delivery_date)){
      elem = $(this).parent()
      result = elem.is( ":button" ) ? elem : elem.parent()
      return
    }
  })

  return result
}

function setSlot(data){
  slot = getSelectedSlot(data)
  $(slot).addClass('slot-selected')
}