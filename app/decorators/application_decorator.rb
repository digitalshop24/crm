class ApplicationDecorator < Draper::Decorator
  def self.collection_decorator_class
    PaginatingDecorator
  end
  def created_at
    if object.created_at
      object.created_at.strftime("%d.%m.%Y %H:%M")
    end
  end
  def inform_date
    if object.inform_date
      object.inform_date.strftime("%d.%m.%Y %H:%M")
    end
  end
  def edit_icon
    h.object_glyphicon_link(object, 'edit', 'Редактировать', { action: :edit })
  end
  def delete_icon
    h.object_glyphicon_link(object, 'remove', 'Удалить', {}, { method: :delete, data: { confirm: "Вы уверены?"} })
  end
end
