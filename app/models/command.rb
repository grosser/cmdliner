class Command < ActiveRecord::Base

  has_many :options, :dependent=>:destroy

  validates_uniqueness_of :name, :case_sensitive => false
  validates_presence_of :name, :description

  def to_s;name;end
end