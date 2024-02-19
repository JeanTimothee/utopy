class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create ]

  def create
    @booking = Booking.find(params[:booking_id])
    @contact = Contact.new(contact_params)
    @contact.booking = @booking
    if @contact.save
      ContactMailer.with(booking: @booking).confirmation_email.deliver_later
      @booking.status = "confirmed"
      if params[:locale] == "en"
        start_date = @booking.start_date.strftime("%Y/%m/%d")
        end_date = @booking.end_date.strftime("%Y/%m/%d")
      else
        start_date = @booking.start_date.strftime("%d/%m/%Y")
        end_date = @booking.end_date.strftime("%d/%m/%Y")
      end
      flash[:booking_successfull] = {
        start_date: start_date,
        end_date: end_date,
        hostel_name: @booking.hostel.name
      }
      redirect_to root_path
    else
      @hostel = @booking.hostel
      render 'hostels/show', status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:phone, :email, :birthdate, :name, :country)
  end
end
