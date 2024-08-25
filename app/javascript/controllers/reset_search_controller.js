import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="reset-search"
export default class extends Controller {

  static targets = ["search", "find"]
  connect() {
  }

  clearSearch() {
    this.searchTarget.value = ""; // Clear the input field
  }
}
