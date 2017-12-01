//= require swiper/swiper.min

$(document).ready(function(){

  var swiper = new Swiper({
    el: '.swiper-container',
    initialSlide: 0,
    spaceBetween: 50,
    slidesPerView: 1,
    centeredSlides: true,
    slideToClickedSlide: true,
    grabCursor: true,
    scrollbar: {
      el: '.swiper-scrollbar',
    },
    mousewheel: {
      enabled: true,
    },
    keyboard: {
      enabled: true,
    },
    pagination: {
      el: '.swiper-pagination',
    },
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
  });

});