import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

// Connects to data-controller="dispo"
export default class extends Controller {
  connect() {
    console.log('connected');
    flatpickr(this.element, {
      altInput: true,
      inline: true,
      minDate: new Date(),
      altFormat: "F j, Y",
      dateFormat: "d-m-Y",
      width: '100%',
      "locale": {
        "firstDayOfWeek": 1 // start week on Monday
    }
      // disableMobile: "true",
    })
  }
}
