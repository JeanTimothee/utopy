import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="success-modal"
export default class extends Controller {
  connect() {
  }

  close() {
    console.log("yo");
    this.element.classList.add("d-none")
  }
}
