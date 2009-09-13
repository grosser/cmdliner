module ApplicationHelper
  def title
    return @title if @title
    if @current_object
      if @current_object.new_record?
        "New #{current_model}"
      else
        @current_object.to_s
      end
    else
      current_model.to_s.pluralize
    end
  end
end