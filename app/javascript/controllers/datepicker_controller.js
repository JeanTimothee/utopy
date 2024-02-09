import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = ["startDate", "numberOfBeds", "price"];
  static values = {booked: Array, hostel: String}

  connect() {
    this.initializeDatepicker();
  }

  initializeDatepicker() {
    const bookedDates = this.bookedValue;

    flatpickr(this.startDateTarget, {
      mode: "range",
      inline: true,
      disable: bookedDates,
      defaultDate: new Date(),
      width: '100%'
    });
    this.calculate();
  }

  updateDatepicker() {
    const hostelId = this.hostelValue;
    const numberOfBeds = this.numberOfBedsTarget.value;
    // Make an AJAX request to fetch updated booked dates based on the selected number of beds
    fetch(`/hostels/${hostelId}/booked_dates?number_of_beds=${numberOfBeds}`)
      .then((response) => response.json())
      .then((data) => {
        this.updateDisabledDates(data.booked_dates);
      });
  }

  updateDisabledDates(bookedDates) {
    flatpickr(this.startDateTarget, {
      mode: "range",
      inline: true,
      disable: bookedDates
      // onChange: (selectedDates) => {
      //   // Handle date change, if needed
      // },
    });
    this.calculate();
  }

  calculate() {
    const hostelId = this.hostelValue;
    const numberOfBeds = this.numberOfBedsTarget.value
    if (this.startDateTarget.value) {
      const date = this.startDateTarget.value

      fetch(`/hostels/${hostelId}/calculate?number_of_beds=${numberOfBeds}&date=${date}`)
        .then((response) => response.json())
        .then((data) => {
          this.priceTarget.innerHTML = `<strong>${(data.price / 100).toFixed(2)} €</strong>`
        });
    } else {
      this.priceTarget.innerHTML = `<strong>0 €</strong>`
    }
  }
}
