class SeosController < ApplicationController
  before_action :set_seo, only: [:show, :edit, :update, :destroy]
  layout 'welcome'
  load_and_authorize_resource
  # GET /seos
  def index
    @seos = Seo.all
  end

  # GET /seos/1
  def show
  end

  # GET /seos/new
  def new
    @seo = Seo.new
  end

  # GET /seos/1/edit
  def edit
  end

  # POST /seos
  def create
    @seo = Seo.new(seo_params)

    if @seo.save
      redirect_to @seo, notice: 'Seo was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /seos/1
  def update
    if @seo.update(seo_params)
      redirect_to @seo, notice: 'Seo was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /seos/1
  def destroy
    @seo.destroy
    redirect_to seos_url, notice: 'Seo was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seo
      @seo = Seo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def seo_params
      params.require(:seo).permit(:name, :description, :title, :code_title)
    end
end
