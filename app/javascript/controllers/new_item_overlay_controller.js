import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-item-overlay"
export default class extends Controller {
  connect() {
    console.log("New item overlay connected")
  }

  deploy (event) {
    let overlayDom = document.querySelector



    overlayDom.classList.add("show");
  }

  // Show the overlay

}
