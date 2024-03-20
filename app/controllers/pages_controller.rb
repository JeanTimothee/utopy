class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :politique, :mentions, :contact ]

  def home
    @hostels = Hostel.all

    @markers = @hostels.map do |hostel|
      {
        lat: (hostel.name == "Garden" ? "43.47241703934897" : "43.473596959312864"),
        lng: (hostel.name == "Garden" ? "-1.5497009611555113" : "-1.5656419880079693"),
        info_window_html: render_to_string(partial: "info_window", locals: {hostel: hostel}),
        marker_html: render_to_string(partial: "marker", locals: {hostel: hostel})
      }
    end
  end

  def contact
    ContactMailer.with(email: params[:email], name: params[:name], message: params[:message]).contact_email.deliver_now!
    flash[:notice] = t('flash.contact_mail')
    redirect_to root_path
  end

  def politique
  end

  def mentions
  end

  def dashboard
    @dispo = params[:dispo] if params[:dispo].present?
    @hostels = Hostel.all
    @garden_booked_dates = Hostel.find_by(name:"Garden").booked_dates
    @coast_booked_dates = Hostel.find_by(name:"Coast").booked_dates
    @booking = Booking.new()
  end

  def dispo
    puts params[:start_date]
    @dispo =  (15 - (Hostel.find(params[:booking][:hostel_id]).nb_of_bookings_per_dates[Date.parse(params[:booking][:start_date])] || 0))
    respond_to do |format|
      format.html { redirect_to dashboard_path(dispo: @dispo) }
      format.json { render json: { dispo: @dispo } }
    end
  end
end
