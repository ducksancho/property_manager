require 'spec_helper'

describe "SessionsController" do
  describe "new" do
    describe "format" do
      it "should right" do
        visit login_path
        page.find_field("session[email]")
        page.find_field("session[password]")
        page.should have_selector("input[type=submit][value='#{I18n.t("link.login")}']")
      end
    end
  end
  describe "create" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    describe "success" do
      it "should save current user" do
        visit login_path
        page.fill_in "session[email]", :with => @user.email
        page.fill_in("session[password]", :with => "password")      
        page.click_button(I18n.t("link.login"))
        page.current_path.should == root_path
        page.should have_content(I18n.t("message.welcome"))
        page.should have_content(@user.name)
      end
    end
    describe "fail" do
      before(:each) do
        visit login_path
        page.fill_in "session[email]", :with => @user.email
        page.fill_in("session[password]", :with => "password")              
      end
      it "with empty format" do
        page.fill_in "session[email]", :with => ""
        page.fill_in "session[password]", :with => ""
        page.click_button(I18n.t("link.login"))
        page.current_path.should == sessions_path
        page.should have_content(I18n.t("message.incorrect_email_or_password"))        
      end
      it "with wrong email" do
        page.fill_in "session[email]", :with => "wrong_email@property_manager.com"
        page.click_button(I18n.t("link.login"))
        page.current_path.should == sessions_path
        page.should have_content(I18n.t("message.incorrect_email_or_password"))
      end
      it "with wrong password" do
        page.fill_in "session[password]", :with => "wrong_password"
        page.click_button(I18n.t("link.login"))
        page.current_path.should == sessions_path
        page.should have_content(I18n.t("message.incorrect_email_or_password"))
      end
    end
  end
  describe "destroy" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      login(@user.email, "password")
    end
    describe "success" do
      it "should logout" do
        visit logout_path
        page.current_path.should == root_path
        page.should have_content(I18n.t("message.logout_success"))
      end
      it "should not show name" do
        visit logout_path
        visit root_path
        page.should_not have_content(@user.name)
      end
    end
  end
end