import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  connect() {
    const swiper = new Swiper('.swiper', {
      loop: true,
      autoplay: {
        delay: 2500, // Delay between transitions (in ms)
        disableOnInteraction: false, // Continue autoplay after user interactions
      },
      // pagination: {
      //   el: '.swiper-pagination',
      // },
      scrollbar: {
        el: '.swiper-scrollbar',
      },
    });
  }
}
