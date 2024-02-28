class PaymentsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action set_booking

  def new
    @visitor_tax = @booking.all_beds.count * 115
    @price_ht = ((@booking.total_price_cents - @visitor_tax) / 1.1).round
    @tva = (@price_ht * 0.1).round.to_s.insert(-3, ".")
    @price_ht = @price_ht.to_s.insert(-3, ".")
    # .to_s.insert(-3, ".")
  end

  def success
    @booking = Booking.find(params[:booking_id])

    ContactMailer.with(booking: @booking).confirmation_email.deliver_later
    ContactMailer.with(booking: @booking).staff_email.deliver_later

    @booking.status = "confirmed"
    @booking.save!

    format = ( params[:locale] == "en" ? "%Y/%m/%d": "%d/%m/%Y" )

    flash[:booking_successfull] =
      {
        start_date: @booking.start_date.strftime(format),
        end_date: @booking.end_date.strftime(format),
        hostel_name: @booking.hostel.name
      }

    redirect_to root_path
  end

  def cancel
    @booking.destroy
    flash[:alert] = "Payment cancelled"
    redirect_to root_path
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

end
