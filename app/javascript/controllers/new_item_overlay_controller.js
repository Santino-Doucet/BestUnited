import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-item-overlay"
export default class extends Controller {
  connect() {
    console.log("New item overlay connected")
  }

  deploy (event) {
    
    let overlayDom = document.querySelector(`.overlay-container`);


    let backDom = document.querySelector(".overlay-back")
    backDom.classList.add("active")

    overlayDom.classList.add("show");
  }

  // Show the overlay

}
