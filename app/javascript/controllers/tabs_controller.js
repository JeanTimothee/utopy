import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {
  static targets = ["block", "dispo"]
  connect() {
  }

  open(event) {
    if (event.params.id === 1) {
      this.blockTarget.classList.toggle('d-none')
    } else if (event.params.id === 2) {
      this.dispoTarget.classList.toggle('d-none')
    }
  }
}
