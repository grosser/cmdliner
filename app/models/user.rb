class User < ActiveRecord::Base
  NAME_FORMAT = /^[-_a-zA-Z\d]+$/

  validates_uniqueness_of :name,  :allow_nil=>false, :on=>:update
  validates_uniqueness_of :email, :allow_nil=>true,  :on=>:update
  validates_format_of :name, :with=>NAME_FORMAT, :on=>:update
  validates_format_of :email, :with=>/.+@.+\..+/, :allow_nil=>true, :on=>:update

  before_create :clean_name, :uniquify_name, :remove_email_when_taken

  attr_accessible :name, :email, :website, :identifier

  def to_s
    name
  end

  def can_create?(object)
    return true if admin?
    case object
    when User then anonymouse?
    when Command then false
    else raise "NOT SUPPORTED"
    end
  end

  def can_write?(object)
    return true if admin?
    case object
    when User then object == self
    when Command then false
    else raise "NOT SUPPORTED"
    end
  end

  def can_read?(object)
    return true if admin?
    case object
    when User, Command then true
    else raise "NOT SUPPORTED"
    end
  end

  protected

  def anonymouse?
    new_record?
  end

  def clean_name
    self.name = name.split(//).select{|x| x =~ NAME_FORMAT}.to_s
  end

  def uniquify_name
    while User.find_by_name(name)
      self.name = "#{name}#{rand(100)}"
    end
  end

  def remove_email_when_taken
    self.email = nil if email and User.find_by_email(email)
  end
end