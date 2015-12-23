class MaterialsController < ApplicationController
   load_and_authorize_resource

  def create
    material_creation_params = material_params.merge(params.require(:material).permit(:order_id))
    @material = Material.new(material_creation_params)
    respond_to do |format|
      if @material.save
        flash[:success] = 'Доработка успешно создана.'
        format.html { redirect_to :back }
        format.json { render :show, status: :created, location: @material }
      else
        flash[:danger] = 'Доработка не была создана.'
        format.html { redirect_to :back }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @material.update(material_params)
      flash[:success] = 'Доработка успешно обновлена.'
      redirect_to :back
    else
      flash[:danger] = 'Доработка не была обновлена.'
      redirect_to :back
    end
  end

  def destroy
    @material.destroy
    flash[:success] = 'Доработка успешно удалена'
    redirect_to :back
  end


  private
  # Use callbacks to share common setup or constraints between actions.

  def invalid_group_number
      logger.error 'Attempt to access invalid group_name #{params[:group_number]}'
      flash[:danger] = 'Неправильный номер группы.'
      redirect_to root_path
    end

  def material_params
    # В данном случае CanCanCan настроен так, что никто не может вызвать update или destroy,
    # если он не Manager или Admin, поэтому отдельно присоединять статус не надо
    if ["Admin", "Manager"].include?(current_user.role)
      params.require(:material).permit(:document, :status)
    else
      params.require(:material).permit(:document)
    end
  end
end
