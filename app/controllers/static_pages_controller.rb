class StaticPagesController < ApplicationController
  def home
    @price_alert = current_user.price_alerts.build if logged_in?
    @price_alerts = PriceAlert.where(user_id: current_user)
  end
end
