import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="birthdate"
export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      altInput: true,
      altFormat: "F j, Y",
      dateFormat: "d-m-Y",
      // disableMobile: "true",
    })
  }
}
