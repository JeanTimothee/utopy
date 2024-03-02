# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def confirmation_email
    ContactMailer.with(user: User.first, booking: Booking.first).confirmation_email
  end

  def staff_email
    @booking = Booking.first
    @booking.total_price_cents = 4400
    ContactMailer.with(user: User.first, booking: @booking).staff_email
    # mail(to: @booking.contact.email, subject: "Booking #{@booking.hostel.name} Utopy Hostel")
  end

  def contact_email
    @name = "Timothée Régis"
    @email = "registimothee@gmail.com"
    @message = "Bonjour, j'adore ce que vous faites, est-ce qu'il y a des vieilles canailles dans vos hostels ? Merci et à bientôt !"
    ContactMailer.with(name: @name, email: @email, message: @message).contact_email
  end
end
