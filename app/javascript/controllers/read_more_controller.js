import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["description", "link"]

  connect() {
    // Ensure the description is hidden initially if desired
    this.descriptionTarget.style.display = "none";
  }

  toggleDescription(event) {
    event.preventDefault(); // Prevent the default link behavior

    if (this.descriptionTarget.style.display === 'none' || this.descriptionTarget.style.display === '') {
      this.descriptionTarget.style.display = 'block';
      this.linkTarget.textContent = 'Réduit';
    } else {
      this.descriptionTarget.style.display = 'none';
      this.linkTarget.textContent = 'En savoir plus';
    }
  }
}
