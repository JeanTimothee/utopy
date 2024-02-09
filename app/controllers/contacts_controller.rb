class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create ]

  def create
    @booking = Booking.find(params[:booking_id])
    @contact = Contact.new(contact_params)
    @contact.booking = @booking
    if @contact.save
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
