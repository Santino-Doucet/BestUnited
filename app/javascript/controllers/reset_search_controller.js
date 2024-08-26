import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="reset-search"
export default class extends Controller {

  static targets = ["search", "address"]

  sleep(milliseconds) {
    return new Promise(resolve => setTimeout(resolve, milliseconds))
  }

  connect() {
    this.searchTarget.value = ""
    this.setInputValueFromUrl()
  }

  async setInputValueFromUrl() {
    // Get the URL parameters
    const params = new URLSearchParams(window.location.search)
    // Retrieve the specific parameter (e.g., "query")
    const searchQuery = params.get('search[query]');
    const searchAddress = params.get('search[address]');

    // Set the value of the input field if parameter is present
    if (searchQuery) {
      this.searchTarget.value = searchQuery;
    }

    if (searchAddress) {
      await this.sleep(1000)
      this.addressTarget.value = searchAddress;
    }
  }

}
