class RestfulController < ApplicationController
  before_filter :can_create, :only=>%w[new create]
  before_filter :can_write, :only=>%w[edit update destroy]
  before_filter :can_read, :only=>%w[show]

  make_resourceful do
    actions :all
  end

  protected

  def can_create
    can_do(:create)
  end

  def can_write
    can_do(:write)
  end

  def can_read
    can_do(:read)
  end

  def can_do(action)
    return if (current_user||User.new).send("can_#{action}?", requested_object)
    access_denied
  end

  def requested_object
    case params[:action]
    when 'new','create' then build_object
    else current_object
    end
  end
end