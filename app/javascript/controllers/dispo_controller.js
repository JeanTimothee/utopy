import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

// Connects to data-controller="dispo"
export default class extends Controller {
  static targets = ['date', 'hostel', 'form', 'results']

  connect() {
    console.log(this.element.action);
    flatpickr(this.dateTarget, {
      altInput: true,
      inline: true,
      minDate: new Date(),
      altFormat: "F j, Y",
      dateFormat: "d-m-Y",
      width: '100%',
      "locale": {
        "firstDayOfWeek": 1 // start week on Monday
      },
    })
  }

  // displayDispo(event) {
  //   console.log(event.currentTarget.value);
  //   console.log(this.dateTarget.value);
  // }
  displayDispo(event) {
    console.log('Date changed:', this.dateTarget.value);
    console.log('Hostel:', this.hostelTarget.value);

    if (this.dateTarget.value && this.hostelTarget.value) {
      fetch(this.formTarget.action, {
        method: "POST",
        headers: { "Accept": "application/json" },
        body: new FormData(this.formTarget)
      })
        .then(response => response.json())
        .then((data) => {
          this.resultsTarget.innerText = `${data.dispo} lits dispo ce jour.`
        })
    }
    // You can perform any action you want here when the date is changed
  }
}
