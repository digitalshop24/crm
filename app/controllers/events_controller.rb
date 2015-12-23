class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /events
  def index
    @events = Event.order(created_at: :desc).preload(:user).paginate(page: params[:page])
  end
  

  # GET /events/1
  def show
    @event.update_attributes(:status => 'visited')
    redirect_to "/#{@event.link}"
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  def create
    respond_to do |format|
      @event = Event.new(event_params)

      if @event.save
        flash.now[:success] = 'Событие сгенерировано'
      else
        flash.now[:error] = 'Ошибка'
        format.html {redirect_to @event}
        format.js
      end
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def event_params
    params.require(:event).permit(:content, :link, :string)
  end
end
