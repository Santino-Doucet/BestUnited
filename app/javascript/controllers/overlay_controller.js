import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="overlay"
export default class extends Controller {
  connect() {
    console.log("Hello from our first Stimulus controller");

  }

  prevent(event) {
    event.stopImmediatePropagation()
  }

  deploy_overlay(event) {
    let overlayDom = document.querySelector(`#item_${event.currentTarget.dataset.id}`);
    console.log(overlayDom);

    let backDom = document.querySelector(".overlay-back")
    backDom.classList.add("active")

    

    overlayDom.classList.add("show");
  }

  remove_overlay() {
    let overlayDom = document.querySelector(`.overlay-container.show`);
    overlayDom.classList.remove("show");

    let backDom = document.querySelector(".overlay-back")
    backDom.classList.remove("active")
  }
}
