import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["details"]

  toggleDetails() {
    this.detailsTarget.style.display = this.detailsTarget.style.display === "none" ? "block" : "none";
  }
}
