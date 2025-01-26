class PriceAlertsController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [ :create, :destroy ]

  # def index
  #   @price_alerts = PriceAlert.where(user_id: current_user)
  # end

  # def show
  #   @price_alert = PriceAlert.find(params[:id])
  # end

  # def new
  #   @price_alert = PriceAlert.new
  # end

  def create
    @price_alert = current_user.price_alerts.build(alert_params)
    if @price_alert.save
      flash[:success] = "Price alert saved!"
      redirect_to root_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def edit
  #   @price_alert = PriceAlert.find(params[:id])
  # end

  def update
    @price_alert = PriceAlert.find(params[:id])

    if @price_alert.update(alert_params)
      redirect_to @price_alert
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @price_alert = PriceAlert.find(params[:id])
    @price_alert.destroy

    redirect_to root_path, status: :see_other
  end

  private
  def alert_params
    params.require(:price_alert).permit(:event_id, :user_id, :alert_price)
  end
end
