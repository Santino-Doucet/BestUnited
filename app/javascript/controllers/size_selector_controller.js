import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="size-selector"
export default class extends Controller {
  static targets = ["size", "form"]
  static values = {itemId: Number}

  connect() {
    // Initialize the slider and set the initial active size
    this.initializeSlider();
  }

  initializeSlider() {
    const slider = this.element.querySelector('.slider');
    const availableSizes = this.sizeTargets
      .filter(option => !option.classList.contains("unavailable"))
      .map(option => parseInt(option.id));
    let form = this.formTarget.parentNode.action;
    if (availableSizes.length > 0) {
      // Set slider min, max, and default value
      // slider.min = Math.min(...availableSizes);
      // slider.max = Math.max(...availableSizes);
      slider.value = Math.min(...availableSizes); // Default to the smallest available size
      fetch(`/items/${this.itemIdValue}/find_item?size=${slider.value}`, {
      })
      .then(response => response.json())
      .then(data => {
        let form_array = form.split("/")
        form_array[4] = data.item_id
        this.formTarget.parentNode.action = form_array.join("/")
        console.log(form)
      })
      // Set the initial active size
      this.updateActiveSize(slider.value);
    }
  }

  updateSize(event) {
    const value = event.currentTarget.value;

    // Only update if the size is available
    if (!this.isSizeUnavailable(value)) {
      this.updateActiveSize(value);
    }
  }

  updateActiveSize(value) {
    // Remove 'active' class from all sizes
    let form = this.formTarget.parentNode.action;
    this.sizeTargets.forEach(option => {
      option.classList.remove("active");
    });

      fetch(`/items/${this.itemIdValue}/find_item?size=${value}`, {
      })
      .then(response => response.json())
      .then(data => {
        let form_array = form.split("/")
        form_array[4] = data.item_id
        this.formTarget.parentNode.action = form_array.join("/")
        console.log(form)
      })

    // Add 'active' class to the selected size
    const selectedOption = document.getElementById(value);
    if (selectedOption) {
      selectedOption.classList.add("active");
    }
  }

  isSizeUnavailable(size) {
    const option = document.getElementById(size);
    return option && option.classList.contains("unavailable");
  }
}
