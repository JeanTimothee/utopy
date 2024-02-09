class HostelsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show, :booked_dates, :calculate ]
  before_action :set_hostel

  def show
    if params[:booking].present?
      @booking = Booking.find(params[:booking])
      @contact = Contact.new
    else
      @booking = Booking.new
      @booked_dates = @hostel.booked_dates
    end
  end

  def booked_dates
    number_of_beds = ( params[:number_of_beds] || 1 ).to_i
    @booked_dates = @hostel.booked_dates(number_of_beds)

    respond_to do |format|
      format.json
      # { render json: { booked_dates: @booked_dates } }
    end
  end

  def calculate
    number_of_beds = ( params[:number_of_beds] || 1 ).to_i
    dates = params[:date]
    if dates.include?("to")
      start_date = Date.parse(params[:date].split(' to ')[0])
      end_date = Date.parse(params[:date].split(' to ')[1])
    else
      start_date = Date.parse(params[:date])
      end_date = start_date + 1
    end
    @booking = Booking.new(start_date: start_date, end_date: end_date, number_of_beds: number_of_beds)
    @booking.hostel = @hostel
    @price = @booking.calculate_price

    respond_to do |format|
      format.json
    end
  end

  private

  def set_hostel
    @hostel = Hostel.find(params[:id])
  end
end
