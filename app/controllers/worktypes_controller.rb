class WorktypesController < ApplicationController
  layout "welcome", only: [:show]
  before_action :set_worktype, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :except => [:show]
  # GET /worktypes
  def index
    @worktypes = Worktype.all
  end

  # GET /worktypes/1
  def show
    @client = Client.new
    @order = Order.new
    @news = News.last
    @question = Question.last
    @feedback = Feedback.last
  end

  # GET /worktypes/new
  def new
    @worktype = Worktype.new
  end

  # GET /worktypes/1/edit
  def edit
  end

  # POST /worktypes
  def create
    @worktype = Worktype.new(worktype_params)

    if @worktype.save
      redirect_to "/worktypes", notice: 'Worktype was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /worktypes/1
  def update
    if @worktype.update(worktype_params)
      redirect_to "/worktypes", notice: 'Worktype was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /worktypes/1
  def destroy
    @worktype.destroy
    redirect_to worktypes_url, notice: 'Worktype was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_worktype
      @worktype = Worktype.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def worktype_params
      params.require(:worktype).permit(:name, :description, :show, :title, :mdescription, :terms, :price)
    end
end
