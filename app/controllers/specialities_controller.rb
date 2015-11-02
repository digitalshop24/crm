class SpecialitiesController < ApplicationController
  before_action :set_speciality, only: [:show, :edit, :update, :destroy]

  # GET /specialities
  def index
    @specialities = Speciality.all
  end

  # GET /specialities/1
  def show
  end

  # GET /specialities/new
  def new
    @speciality = Speciality.new
  end

  # GET /specialities/1/edit
  def edit
  end

  # POST /specialities
  def create
    @speciality = Speciality.new(speciality_params)

    if @speciality.save
      redirect_to @speciality, notice: 'Speciality was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /specialities/1
  def update
    if @speciality.update(speciality_params)
      redirect_to @speciality, notice: 'Speciality was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /specialities/1
  def destroy
    @speciality.destroy
    redirect_to specialities_url, notice: 'Speciality was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_speciality
      @speciality = Speciality.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def speciality_params
      params.require(:speciality).permit(:name)
    end
end
