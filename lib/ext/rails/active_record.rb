# http://github.com/grosser/clear_empty_attributes/blob/master/lib/clear_empty_attributes.rb
class ActiveRecord::Base
  before_validation :clear_empty_attrs

  protected

  def clear_empty_attrs
    @attributes.each do |key,value|
      self[key] = nil if value.is_a?(String) && value.blank?
    end
  end
end