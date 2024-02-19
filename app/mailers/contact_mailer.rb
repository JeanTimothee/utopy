class ContactMailer < ApplicationMailer
  default from: 'utopy.hostel@gmail.com'

  def confirmation_email
    @booking = params[:booking]
    mail(to: @booking.contact.email, subject: "Booking #{@booking.hostel.name} Utopy Hostel")
  end
end
