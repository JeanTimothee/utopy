class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create ]

  def create
    @booking = Booking.find(params[:booking_id])
    @contact = Contact.new(contact_params)
    @contact.booking = @booking

    if @contact.save!
      # testing purpose
      # ContactMailer.with(booking: @booking).confirmation_email.deliver_later

      session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        quantity: 1,
        price_data: {
          unit_amount: @booking.total_price_cents.to_i,
          currency: 'eur',
          product_data: {
            name: "#{@booking.number_of_beds} bed(s)"
          }
        }
      ],
      mode: "payment",
      success_url: booking_payments_success_url(@booking),
      cancel_url: booking_payments_cancel_url(@booking)
      )


    @booking.checkout_session_id = session.id
    @booking.save

    redirect_to new_booking_payment_path(@booking)

    else
      @hostel = @booking.hostel
      render 'hostels/show', status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:phone, :email, :birthdate, :first_name, :last_name, :country)
  end
end
