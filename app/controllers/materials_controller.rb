class MaterialsController < ApplicationController
   load_and_authorize_resource

  def create
    material_creation_params = material_params.merge(params.require(:material).permit(:order_id))
    @material = Material.new(material_creation_params)
      if @material.save
        redirect_to :back, notice: 'Файл успешно создан.'
      else
        flash[:danger] = 'Файл не была создан.'
        redirect_to :back 
      end
  end

  def update
    if @material.update(material_params)
      redirect_to :back, notice: 'Файл успешно обновлен.'
    else
      flash[:danger] = 'Файл не была обновлен.'
      redirect_to :back
    end
  end

  def destroy
    @material.destroy
    flash[:success] = 'Файл успешно удален'
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
      params.require(:material).permit(:document, :status, :order_id)
    else
      params.require(:material).permit(:document, :order_id)
    end
  end
end
