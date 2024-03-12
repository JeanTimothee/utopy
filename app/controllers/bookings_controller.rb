class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create, :booked_dates ]
  before_action :set_hostel

  def create
    @number_of_beds = params[:booking][:number_of_beds]
    @booking = Booking.new()
    if params[:booking][:start_date].present? && params[:booking][:start_date].split(' to ').count == 2
      start_date = Date.parse(params[:booking][:start_date].split(' to ')[0])
      end_date = Date.parse(params[:booking][:start_date].split(' to ')[1])
      @booking = Booking.new(start_date: start_date, end_date: end_date, number_of_beds: @number_of_beds.to_i)
      @booking.hostel = @hostel
      @booking.total_price_cents = @booking.calculate_price
    end

    if (@hostel.available_beds(@booking.start_date, @booking.end_date).count >= @booking.number_of_beds.to_i) && @booking.save
      @hostel.available_beds(@booking.start_date, @booking.end_date).sample(@booking.number_of_beds).each do |bed|
        beds_booking = BedsBooking.new()
        beds_booking.bed = bed
        beds_booking.booking = @booking
        beds_booking.save!
      end
      redirect_to hostel_path(@hostel, booking: @booking.id)
    else
      @booked_dates = @hostel.booked_dates
      render 'hostels/show', status: :unprocessable_entity
    end
  end

  def block_beds
    @number_of_beds = params[:booking][:number_of_beds]
    @booking = Booking.new()
    if params[:booking][:start_date].present? && params[:booking][:start_date].split(' to ').count == 2
      start_date = Date.parse(params[:booking][:start_date].split(' to ')[0])
      end_date = Date.parse(params[:booking][:start_date].split(' to ')[1])
      @booking = Booking.new(start_date: start_date, end_date: end_date, number_of_beds: @number_of_beds.to_i)
      @booking.hostel = @hostel
      @booking.total_price_cents = @booking.calculate_price
    end

    if (@hostel.available_beds(@booking.start_date, @booking.end_date).count >= @booking.number_of_beds.to_i) && @booking.save!
      @hostel.available_beds(@booking.start_date, @booking.end_date).sample(@booking.number_of_beds).each do |bed|
        beds_booking = BedsBooking.new()
        beds_booking.bed = bed
        beds_booking.booking = @booking
        beds_booking.save!
      end
      @booking.status = "confirmed"
      @booking.save!

      format = ( params[:locale] == "en" ? "%Y/%m/%d": "%d/%m/%Y" )

      flash[:booking_successfull] =
      {
        start_date: @booking.start_date.strftime(format),
        end_date: @booking.end_date.strftime(format),
        hostel_name: @booking.hostel.name
      }
      redirect_to dashboard_path
    else
      @booked_dates = @hostel.booked_dates
      render 'dashboard', status: :unprocessable_entity
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


  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy

    flash[:alert] = t('flash.cancel_booking')
    redirect_to root_path, status: :see_other
  end


  private

  def set_hostel
    @hostel = Hostel.find(params[:hostel_id])
  end

  def booking_params
    require(:booking).permit(:start_date, :end_date, :status, :checkout_session_id, :number_of_beds, :total_price_cents)
  end
end
