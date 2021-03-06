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
    @user = User.new(activated: true)
  end

  def create
    @user = User.new(user_params)
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
    parms.delete(:speciality_ids)
    parms.delete(:subspeciality_ids)
    if @user.update_attributes(parms)
      if @user.role == 'Employee'
        @user.speciality.clear
        @user.subspeciality.clear
        if params[:user][:speciality_ids]
          params[:user][:speciality_ids].each do |s|
            begin
              @user.speciality<<Speciality.find(s)
            rescue
              @mes = "Нельзя выбирать одинаквые специальности"
             end
          end
        end
        if  params[:user][:subspeciality_ids]
          params[:user][:subspeciality_ids].each do |s|
            begin
            @user.subspeciality<<Subspeciality.find(s)
          rescue
              @mes = "Нельзя выбирать одинаквые специальности"
            end
          end
        end
      end
      if @mes 
         flash[:danger] = @mes
      else
        flash[:notice] = "Пользователь обновлен"
      end
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



  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    permitted_arr = [:role, :email, :password, :name, :phone, :city, :activated]
    if params[:user][:role] == 'Employee'
      permitted_arr << [:skype, speciality_ids: [], subspeciality_ids: []]
    end
    params.require(:user).permit(permitted_arr)
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def show_role
    params[:role] if ( params[:role] and User::ROLES.include? params[:role].downcase )
  end
end
