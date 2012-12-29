require 'spec_helper'

describe "UsersController" do
  describe "new" do
    before(:each) do
      @valid_signup_code = "HAPPYNEWYEAR"
    end
    describe "view" do
      it "should right" do
        visit new_user_path(:signup_code => @valid_signup_code)
        page.find_field("user[f_name]")
        page.find_field("user[l_name]")
        page.find_field("user[email]")
        page.find_field("user[password]")
        page.find_field("user[password_confirmation]")
        page.should have_xpath("//input[@name = 'user[signup_code]'][@value = '#{@valid_signup_code}']")
      end
    end
    describe "without signup_code" do
      it "should show root page with error" do
        visit new_user_path
        page.current_path.should == "/"
        page.should have_content(I18n.t("message.no_signup_without_signup_code"))
      end
    end
    describe "with signup_code" do
      describe "valid" do
        it "should show the form" do
          visit new_user_path(:signup_code => @valid_signup_code)
          page.should have_xpath("//form[@id = 'new_user']")
        end        
      end
      describe "invalid" do
        it "should redirect to root_path and show a message" do
          visit new_user_path(:signup_code => "invalid_code")
          page.current_path.should == "/"
          page.should have_content(I18n.t("message.signup_code_invalid"))
        end
      end
      describe "used" do
        before(:each) do
          FactoryGirl.create(:user, :signup_code => @valid_signup_code)
        end
        it "should redirect to root_path and show a message" do
          visit new_user_path(:signup_code => "invalid_code")
          page.current_path.should == "/"
          page.should have_content(I18n.t("message.signup_code_invalid"))          
        end
      end
    end
  end
  describe "create" do
    
  end
end
