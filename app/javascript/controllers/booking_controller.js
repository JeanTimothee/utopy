import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="booking"
export default class extends Controller {
  static targets = ["calendar", "trigger"];

  connect() {
  }

  showBookingModal() {
    // Show the modal
    this.calendarTarget.classList.remove("d-none");
    // Hide the footer
    this.triggerTarget.classList.add("d-none");
  }
}
