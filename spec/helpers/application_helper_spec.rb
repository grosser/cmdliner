require 'spec/spec_helper'

describe ApplicationHelper do
  include ApplicationHelper

  describe :title do
    before do
      stub!(:current_model).and_return User
    end

    it "fetches the title from @title" do
      @title = 'YEP'
      title.should == @title
    end

    it "gets the title from current_object" do
      user = Factory(:user)
      @current_object = user
      title.should == user.to_s
    end

    it "gets the title from new objects" do
      user = Factory.build(:user)
      @current_object = user
      title.should == "New User"
    end

    it "gets the title from current_model" do
      title.should == 'Users'
    end
  end
end