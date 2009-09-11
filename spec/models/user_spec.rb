require 'spec/spec_helper'

describe User do
  describe "ACL" do
    before :all do
      @owner = Factory(:user)
      @other = Factory(:user)
      @noone = User.new
    end

    it "User" do
      user = User.find(@owner.id)
      behaves_like_owner_changeable(user)
    end

    def behaves_like_owner_changeable(item)
      check_can(:read, true, true, true, item)
      check_can(:write, true, false, false, item)
      check_can(:create, nil, false, true, item)
    end

    def check_can(action, owner, other, noone, item)
      method = "can_#{action}?"
      @owner.send(method, item).should == owner unless owner == nil
      @other.send(method, item).should == other
      @noone.send(method, item).should == noone
    end
  end

  describe :name do
    it "is made uniqe" do
      Factory.build(:user, :name=>'xxx').save!
      user2 = Factory.build(:user, :name=>'xxx')
      user2.save!
      user2.name.should_not == 'xxx'
    end

    it "is cleaned" do
      user = Factory.build(:user,:name=>'ÁÄasÐ§82#*@#@')
      user.save!
      user.name.should == 'as82'
    end

    it "is invalid when changed to invalid" do
      user = Factory(:user)
      user.name = '324@'
      user.save.should == false
    end
  end

  describe :email do
    it "is stored when uniq" do
      user = Factory.build(:user,:email=>'xxx@xxx.com')
      user.save!
      user.email.should == 'xxx@xxx.com'
    end

    it "is removed on create when not unique" do
      Factory.build(:user,:email=>'xxx@xxx.com').save!
      user = Factory.build(:user,:email=>'xxx@xxx.com')
      user.save!
      user.email.should == nil
    end

    it "is invalid when changed to invalid" do
      user = Factory(:user)
      user.valid?
      puts user.errors.full_messages
      user.should be_valid
      user.email = '324@'
      user.should_not be_valid
    end

    it "is invalid when changed to non-unique" do
      mail = 'adsa@sadd.com'
      user = Factory(:user, :email=>mail)
      user2 = Factory(:user, :email=>'xxx@sdas.sdsds')
      user2.should be_valid
      user2.email = mail
      user2.should_not be_valid
    end
  end
end