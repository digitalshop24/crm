class RegistrationsController < Devise::RegistrationsController
  before_action :set_specialities, only: [:new, :edit, :add_speciality, :update, :create]

  def update_specialities
    @specialitiy_number = params[:speciality_number]
    unless params[:speciality_id].empty?
      @subspecialities = Subspeciality.where("speciality_id = ?", params[:speciality_id])
    else
      @subspecialities = Subspeciality.where(id: nil)
    end
    respond_to do |format|
      format.js { render 'users/update_specialities' }
    end
  end

  def add_speciality
    @speciality_number = rand(0..10000)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'users/add_speciality' }
    end
  end
end
