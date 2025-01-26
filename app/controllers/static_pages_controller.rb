class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @price_alert = current_user.price_alerts.build
      @price_alerts = PriceAlert.where("user_id = ?", current_user)
    end
  end
end
