require 'spec_helper'

describe "PropertiesController" do
  describe "index" do
    before(:each) do
      # create a user
      @user = FactoryGirl.create(:user)
      login(@user.email, "password")
      # create properties
      5.times do
        FactoryGirl.create(:property)
      end
    end
    it "show all properties", :focus => true do
      visit properties_path
      Property.all.each do |property|


      end
    end
  end
end
