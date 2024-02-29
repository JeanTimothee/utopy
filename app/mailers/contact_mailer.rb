class ContactMailer < ApplicationMailer
  default from: 'utopy.hostel@gmail.com'

  def confirmation_email
    @booking = params[:booking]
    mail(to: @booking.contact.email, subject: "Booking #{@booking.hostel.name} Utopy Hostel")
  end

  def staff_email
    @booking = params[:booking]
    target = (@booking.hostel == Hostel.find_by(name: "Coast") ? "utopycoast@gmail.com" : "utopy.hostel@gmail.com")
    mail(to: target, subject: "Booking #{@booking.number_of_beds} beds from #{@booking.start_date.strftime("%d/%m/%Y")} to #{@booking.end_date.strftime("%d/%m/%Y")} at #{@booking.hostel.name}")
  end
end
