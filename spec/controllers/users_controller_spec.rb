require 'spec/spec_helper'

describe UsersController do
  describe :create do
    it "redirects when not called with valid token" do
      RPXNow.stub!(:user_data).and_return nil
      post :create, :token=>'xxxx'
      it_redirects '/login'
    end

    it "creates a user when called with unknown identifier" do
      RPXNow.stub!(:user_data).and_return :identifier=>'IDENT', :username=>'meko'
      lambda{
        post :create, :token=>'xxxx'
      }.should change(User,:count).by(+1)

      User.last.identifier.should == 'IDENT'
      session[:user_id].should == User.last.id
      it_redirects '/'
    end

    it "logs in a user when called with know identifier" do
      user = Factory(:user)
      RPXNow.stub!(:user_data).and_return :identifier=>user.identifier, :username=>'meko'
      lambda{
        post :create, :token=>'xxxx'
      }.should_not change(User, :count)

      session[:user_id].should == user.id
      it_redirects '/'
    end
  end
end