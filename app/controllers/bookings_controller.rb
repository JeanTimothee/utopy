class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create ]
  def create
    start_date = Date.parse(params[:booking][:start_date].split(' to ')[0])
    end_date = Date.parse(params[:booking][:start_date].split(' to ')[1])
    @booking = Booking.new(start_date: start_date, end_date: end_date, total_price_cents: 18000)
    @booking.user = current_user
    @booking.save!
    raise
  end

  # def booking_params
  #   params.require(:booking).permit(:start_date, :end_date)
  # end
end
