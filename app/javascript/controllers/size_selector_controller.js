import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="size-selector"
export default class extends Controller {
  static targets = ["size"]

  connect() {
    // this.updateSize()
  }

  updateSize(event) {
    const value = event.currentTarget.value;

    this.sizeTargets.forEach(option => {
      option.classList.remove("active");
    });

    document.getElementById(`${value}`).classList.add("active")
  }
}
