class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create ]
  def create
    @hostel = Hostel.find(params[:hostel_id])
    @number_of_beds = params[:booking][:number_of_beds]
    if params[:booking][:start_date].present?
      start_date = Date.parse(params[:booking][:start_date].split(' to ')[0])
      end_date = Date.parse(params[:booking][:start_date].split(' to ')[1])
      @booking = Booking.new(start_date: start_date, end_date: end_date, number_of_beds: @number_of_beds)
      @booking.hostel = @hostel
      @booking.total_price_cents = @booking.calculate_price
    end
    if @booking.save
      redirect_to hostel_path(@hostel, booking: @booking.id)
    else
      render 'hostels/show', status: :unprocessable_entity
    end
  end

  # def booking_params
  #   params.require(:booking).permit(:start_date, :end_date)
  # end
end
