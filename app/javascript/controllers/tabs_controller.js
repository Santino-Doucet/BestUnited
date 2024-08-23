import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["tab", "section"];

  connect() {
    const activeTab = this.tabTargets.find(tab => tab.classList.contains('active'));
    if (activeTab) {
      this.showSection(activeTab);
    }
  }

  switchTab(event) {
    event.preventDefault();
    const clickedTab = event.currentTarget;

    this.tabTargets.forEach(tab => tab.classList.remove('active'));

    clickedTab.classList.add('active');

    this.showSection(clickedTab);
  }

  showSection(tab) {
    const target = tab.getAttribute('data-target');

    this.sectionTargets.forEach(section => section.classList.remove('active'));

    const targetSection = this.sectionTargets.find(section => section.id === target);
    if (targetSection) {
      targetSection.classList.add('active');
    }
  }
}
