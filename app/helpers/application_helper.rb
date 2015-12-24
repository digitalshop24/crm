module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(sort: column, direction: direction, page: nil), remote: true, class: css_class
  end
end

module ActionView
  module Helpers
    class FormBuilder
      def date_select(method, options = {}, html_options = {})
        existing_date = @object.send(method)
        formatted_date = existing_date.to_date.strftime("%d.%m.%Y") if existing_date.present?
        @template.content_tag(:div, class: "input-group date datepicker") do
          text_field(method, value: formatted_date, class: "form-control", "data-date-format" => "DD.MM.YYYY") +
            @template.content_tag(:span, @template.content_tag(:span, "", class: "glyphicon glyphicon-calendar"), class: "input-group-addon")
        end
      end

      def datetime_select(method, options = {}, html_options = {})
        existing_time = @object.send(method)
        formatted_time = existing_time.to_time.strftime("%d.%m.%Y %H:%M") if existing_time.present?
        @template.content_tag(:div, class: "input-group date datetimepicker") do
          text_field(method, value: formatted_time, class: "form-control", "data-date-format" => "DD.MM.YYYY HH:mm") +
            @template.content_tag(:span, @template.content_tag(:span, "", class: "glyphicon glyphicon-calendar"), class: "input-group-addon")
        end
      end
    end
  end
end
