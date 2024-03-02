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
    ContactMailer.with(email: params[:email], name: params[:name], message: params[:message]).contact_email.deliver_later
    flash[:notice] = t('flash.contact_mail')
    redirect_to root_path
  end

  def politique
  end

  def mentions
  end

end
