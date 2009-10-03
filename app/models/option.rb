class Option < ActiveRecord::Base
  belongs_to :command
  def to_s;name||self.alias;end
end