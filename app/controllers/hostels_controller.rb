class HostelsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  def show
    @hostel = Hostel.find(params[:id])
    @booking = Booking.new
  end
end
