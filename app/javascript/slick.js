$(function () {
  $('.slider').slick({
    prevArrow: '<span class="prev-arrow"><i class="fas fa-chevron-circle-left"></i></span>',
    nextArrow: '<span class="next-arrow"><i class="fas fa-chevron-circle-right"></i></span>',
    slidesToShow: 3,
    slidesToScroll: 1,
    autoplay: true,
    autoplaySpeed: 2000,
    responsive: [
      {
        breakpoint: 1010,
        settings: {
          slidesToShow: 2,
        }
      },
      {
        breakpoint: 510,
        settings: {
          slidesToShow: 1,
        }
      }
    ]
  });
});
