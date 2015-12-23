class WorktypesController < ApplicationController
  before_action :set_worktype, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /worktypes
  def index
    @worktypes = Worktype.all
  end

  # GET /worktypes/1
  def show
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
      redirect_to @worktype, notice: 'Worktype was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /worktypes/1
  def update
    if @worktype.update(worktype_params)
      redirect_to @worktype, notice: 'Worktype was successfully updated.'
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
      params.require(:worktype).permit(:name)
    end
end
