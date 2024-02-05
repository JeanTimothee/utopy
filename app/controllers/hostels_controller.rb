class HostelsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  def show
    @hostel = Hostel.find(params[:id])
    if params[:booking].present?
      @booking = Booking.find(params[:booking])
      @contact = Contact.new
    else
      @booking = Booking.new
    end
  end
end
