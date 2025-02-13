class EventsController < ApplicationController
  before_action :logged_in_user, only: [ :new, :create ]
  def index
    @events = Event.all.paginate(page: params[:page])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to events_path, status: :see_other
  end

    private
    def event_params
      params.require(:event).permit(:name, :date, :venue, :live_price_cad,
                                    :live_price_usd, :url, :stubhub_id, :image_url, :event_type)
    end
end
