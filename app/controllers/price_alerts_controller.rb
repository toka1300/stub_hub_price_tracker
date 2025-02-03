class PriceAlertsController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [ :create, :destroy ]
  before_action :correct_user, only: :destroy

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
      puts @price_alert.errors.full_messages  # Debug output
      @price_alerts = PriceAlert.where("user_id = ?", current_user)
      render "static_pages/home", status: :unprocessable_entity
    end
  end

  # def edit
  #   @price_alert = PriceAlert.find(params[:id])
  # end

  # def update
  #   @price_alert = PriceAlert.find(params[:id])

  #   if @price_alert.update(alert_params)
  #     redirect_to @price_alert
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end

  def destroy
    @price_alert.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("price-alert-#{@price_alert.id}") }
      format.html { redirect_to root_path, status: :see_other }
    end
  end

  private
  def alert_params
    params.require(:price_alert).permit(:event_id, :user_id, :alert_price)
  end

  def correct_user
    @price_alert = current_user.price_alerts.find_by(id: params[:id])
    redirect_to root_url, status: :see_other if @price_alert.nil?
  end
end
