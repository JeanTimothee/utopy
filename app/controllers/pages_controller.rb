class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @hostels = Hostel.all

    @markers = @hostels.geocoded.map do |hostel|
      {
        lat: hostel.latitude,
        lng: hostel.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {hostel: hostel}),
        marker_html: render_to_string(partial: "marker", locals: {hostel: hostel})
      }
    end
  end

  def politique
  end

  def mentions
  end
end
