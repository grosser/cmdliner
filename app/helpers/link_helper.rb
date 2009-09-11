module LinkHelper
  def link_to_s(object)
    link_to object.to_s, object
  end
end