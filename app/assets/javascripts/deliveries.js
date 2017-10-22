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
console.log("como")
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