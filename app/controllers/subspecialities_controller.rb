class SubspecialitiesController < ApplicationController
  load_and_authorize_resource
  before_action :set_subspeciality, only: [:show, :edit, :update, :destroy]

  # GET /subspecialities
  def index
    @specialities = Speciality.all
    @subspecialities = Subspeciality.all
  end

  # GET /subspecialities/1
  def show
  end

  # GET /subspecialities/new
  def new
    @subspeciality = Subspeciality.new(speciality_id: params[:speciality_id])
  end

  # GET /subspecialities/1/edit
  def edit
  end

  # POST /subspecialities
  def create
  p = {subspeciality: params[:subspeciality]["subspeciality"], speciality_id: params[:speciality_id] }
    @subspeciality = Subspeciality.new(p)

    if @subspeciality.save
      redirect_to "/specialities", notice: 'Подспециальность успешна создана'
    else
      render :new
    end
  end

  # PATCH/PUT /subspecialities/1
  def update
    if @subspeciality.update(subspeciality_params)
      redirect_to "/specialities", notice: 'Подспециальность успешно обновлена'
    else
      render :edit
    end
  end

  # DELETE /subspecialities/1
  def destroy
    @subspeciality.destroy
    redirect_to "/specialities", notice: 'Подспециальность успешно удалена'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subspeciality
      @subspeciality = Subspeciality.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def subspeciality_params
      params.require(:subspeciality).permit(:subspeciality, :speciality_id)
    end
end
