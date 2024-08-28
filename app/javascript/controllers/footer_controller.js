// app/javascript/controllers/footer_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["item"];

  connect() {
    this.updateActiveState();
  }

  updateActiveState() {
    // Get the current path
    const currentPath = window.location.pathname;

    // Iterate through all footer items
    this.itemTargets.forEach((item) => {
      const link = item.querySelector("a");
      if (link && link.getAttribute("href") === currentPath) {
        // Add active class to the matched item
        item.classList.add("active");
      } else {
        // Remove active class from unmatched items
        item.classList.remove("active");
      }
    });
  }

  select(event) {
    // Prevent default behavior
    event.preventDefault();

    // Remove active class from all items
    this.itemTargets.forEach((item) => item.classList.remove("active"));

    // Add active class to the clicked item
    event.currentTarget.classList.add("active");

    // Navigate to the link of the clicked item
    const link = event.currentTarget.querySelector("a");
    if (link) {
      window.location.href = link.getAttribute("href");
    }
  }
}
