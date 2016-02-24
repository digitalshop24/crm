class ActionsController < ApplicationController
  layout 'welcome'
  before_action :set_action, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /action
  def index
    @worktypes = Worktype.all
    @actions = Action.all.order(date: :desc).paginate(:page => params[:page], :per_page => 4)
  end

  # GET /action/1
  def show
  end

  # GET /action/new
  def new
    @action = Action.new
  end

  # GET /action/1/edit
  def edit
  end

  # POST /action
  def create
    @action = Action.new(action_params)

    if @action.save
      redirect_to "/actions", notice: 'action was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /action/1
  def update
    if @action.update(action_params)
      redirect_to "/actions", notice: 'action was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /action/1
  def destroy
    @action.destroy
    redirect_to action_index_url, notice: 'action was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_action
      @action = Action.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def action_params
      permitted_arr = [:title, :text, :image, :date]
    params.require(:action).permit(permitted_arr)
    end
end
