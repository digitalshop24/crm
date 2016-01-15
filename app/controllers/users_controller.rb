class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  load_and_authorize_resource
  before_action :set_specialities, only: [:new, :edit, :add_speciality, :update, :create]

  def index
    @users = User.all
    @users = User.where(role: show_role) if show_role
    @users = @users.search(params[:search]) if params[:search]
    @users = @users.order(sort_column + " " + sort_direction) if sort_column
    @users = @users.paginate(page: params[:page], per_page: 15)
  end

  def manage
    @users = User.paginate(page: params[:page], per_page: 15)
  end

  def new
    @user = User.new
  end

  def create
    parms = user_params
    if parms[:speciality_ids]
      parms[:speciality_ids].uniq!
      parms[:subspeciality_ids].uniq!
    end
    @user = User.new(parms)
    if @user.save
      flash[:notice] = "Пользователь успешно создан"
      redirect_to users_path
    else
      render action: 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    parms = user_params
    parms.delete(:password) if parms[:password].blank?
    parms.delete(:password_confirmation) if parms[:password].blank? and parms[:password_confirmation].blank?
    if parms[:speciality_ids]
      parms[:speciality_ids].uniq!
      parms[:subspeciality_ids].uniq!
    end
    if @user.update_attributes(parms)
      flash[:notice] = "Пользователь обновлен"
      redirect_to action: :index
    else
      render action: 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "Пользователь удален"
      redirect_to :back
    end
  end

  def add_speciality
    @speciality_number = rand(0..10000)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end



  # Only allow a trusted parameter "white list" through.
  def user_params
    permitted_arr = [:role, :email, :password, :name, :phone, :city]
    if params[:user][:role] == 'Employee'
      permitted_arr << [:skype, speciality_ids: [], subspeciality_ids: []]
    end
    params.require(:user).permit(permitted_arr)
  end

  def sort_column
    params[:sort] if User.column_names.include?(params[:sort])
  end

  def show_role
    params[:role] if ( params[:role] and User::ROLES.include? params[:role].downcase )
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
