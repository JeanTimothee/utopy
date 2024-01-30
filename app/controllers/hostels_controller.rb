class HostelsController < ApplicationController
  def show
    @hostel = Hostel.find(params[:id])
    @booking = Booking.new
  end
end
