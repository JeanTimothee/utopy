class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :politique, :mentions ]

  def home
    @hostels = Hostel.all

    @markers = @hostels.map do |hostel|
      # 43.47363004428891, -1.56565228917027
      {
        lat: (hostel.name == "Garden" ? "43.47241703934897" : "43.473596959312864"),
        lng: (hostel.name == "Garden" ? "-1.5497009611555113" : "-1.5656419880079693"),
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
