class String
  def split_after(max, options={})
    zero_length_space = '​' #aka &#8203;
    options[:with] ||= zero_length_space
    split(/ /).map do |part|
      part = part.mb_chars
      if part.length > max
        part[0...max] + options[:with] + part[max..-1].to_s.split_after(max)
      else
        part
      end
    end * ' '
  end
end


#ActionView text helpers
class String
  %w[auto_link excerpt highlight sanitize simple_format strip_tags word_wrap].each do |method|
    eval <<-EVAL
    def #{method}(*args)
      ActionController::Base.helpers.#{method}(self, *args)
    end
EVAL

    def truncate(*args)
      #called with only a number
      if args.size == 1 and args[0].to_s =~ /^\d+$/
        ActionController::Base.helpers.truncate(self, :length=>args[0])
      else
        ActionController::Base.helpers.truncate(self, *args)
      end
    end
  end
end


# user.name.blank_to_nil || 'default name'
class String
  def blank_to_nil
    blank? ? nil : self
  end
end

class NilClass
  def blank_to_nil
    self
  end
end