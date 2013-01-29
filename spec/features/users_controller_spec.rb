require 'spec_helper'

describe "UsersController" do
  before(:each) do
    @valid_signup_code = "HAPPYNEWYEAR"    
  end
  describe "new" do
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
    before(:each) do
      visit new_user_path(:signup_code => @valid_signup_code)
      page.fill_in("user[f_name]", :with => "ducksan")
      page.fill_in("user[l_name]", :with => "cho")
      page.fill_in("user[email]", :with => "ducksan@pm.com")
      page.fill_in("user[password]", :with => "password")
      page.fill_in("user[password_confirmation]", :with => "password")      
    end
    describe "success" do
      it "should create" do
        lambda do
          page.click_button(I18n.t("link.register"))
        end.should change(User, :count).by(1)
        user = User.last
        user.f_name.should == "ducksan"
        user.l_name.should == "cho"
        user.email.should == "ducksan@pm.com"
        user.signup_code.should == @valid_signup_code
        user.salt.should_not be_blank
        user.encrypted_password.should_not be_blank
      end
      it "should redirect to root_path" do
        page.click_button(I18n.t("link.register"))
        page.current_path.should == root_path
      end      
    end
    describe "fail" do
      it "validation error" do
        page.fill_in("user[f_name]", :with => "")
        lambda do
          page.click_button(I18n.t("link.register"))
        end.should_not change(User, :count)
        page.should have_content("First Name can't be blank")
      end
      it "signup code is already used" do
        FactoryGirl.create(:user)
        lambda do
          page.click_button(I18n.t("link.register"))
        end.should_not change(User, :count)
        page.should have_content(I18n.t("message.signup_code_used"))
        page.current_path.should == root_path
      end
    end
  end
  describe "edit" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    describe "view" do
      describe "logout user" do
        it "should right" do
          visit edit_user_path(@user)
          page.current_path.should == login_path
        end
      end
      describe "current user" do
        before(:each) do
          login(@user.email, "password")
        end
        it "should right" do
          visit edit_user_path(@user)
          page.find_field("user[f_name]")
          page.find_field("user[l_name]")
          page.find_field("user[email]")
          page.should_not have_xpath("//input[@name = 'user[password]']")
          page.should_not have_xpath("//input[@name = 'user[password_confirmation]']")
          page.should_not have_xpath("//input[@name = 'user[signup_code]'][@value = '#{@valid_signup_code}']")
        end                
      end
      describe "other user" do
        before(:each) do
          @new_user = FactoryGirl.create(:user)
          login(@user.email, "password")
        end
        it "should right" do
          visit edit_user_path(@new_user)          
          page.current_path.should == root_path
          page.should have_content(I18n.t("message.access_denied"))
        end        
      end
    end
  end
  describe "update" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      login(@user.email, "password") 
      visit edit_user_path(@user)
    end
    describe "success" do
      it "should update user" do
        page.fill_in("user[f_name]", :with => "new first name")
        page.fill_in("user[l_name]", :with => "new last name")
        page.fill_in("user[email]", :with => "newemail@pm.com")
        page.click_button(I18n.t("link.update"))
        page.current_path.should == root_path
        page.should have_content(I18n.t("message.user_updated"))
      end
    end
    describe "fail" do
      it "wrong email format" do
        page.fill_in("user[f_name]", :with => "new first name")
        page.fill_in("user[l_name]", :with => "new last name")
        page.fill_in("user[email]", :with => "new email")
        page.click_button(I18n.t("link.update"))
        page.current_path.should == user_path(@user.id)
        page.should have_content("E-Mail is invalid")
      end
    end
  end
  describe "edit_password" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      login(@user.email, "password") 
    end
    describe "success" do
      it "should right" do
        visit edit_password_user_path(@user)
        page.should have_xpath("//input[@name = 'user[original_password]']")
        page.should have_xpath("//input[@name = 'user[password]']")
        page.should have_xpath("//input[@name = 'user[password_confirmation]']")
      end      
      describe "current user" do
        before(:each) do
          login(@user.email, "password")
        end
        it "should right" do
          visit edit_password_user_path(@user)
          page.should have_xpath("//input[@name = 'user[original_password]']")
          page.should have_xpath("//input[@name = 'user[password]']")
          page.should have_xpath("//input[@name = 'user[password_confirmation]']")
        end                
      end
      describe "other user" do
        before(:each) do
          @new_user = FactoryGirl.create(:user)
          login(@user.email, "password")
        end
        it "should right" do
          visit edit_user_path(@new_user)          
          page.current_path.should == root_path
          page.should have_content(I18n.t("message.access_denied"))
        end        
      end
    end
  end
  describe "update_password" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      login(@user.email, "password") 
      visit edit_password_user_path(@user)
    end
    describe "success" do
      it "should update user" do
        page.fill_in("user[original_password]", :with => "password")
        page.fill_in("user[password]", :with => "new_password")
        page.fill_in("user[password_confirmation]", :with => "new_password")
        page.click_button(I18n.t("link.update"))
        page.current_path.should == root_path
        page.should have_content(I18n.t("message.password_updated"))
        visit logout_path
        login(@user.email, "new_password")
        current_path.should == root_path
        page.should have_content(I18n.t("message.welcome"))
      end
    end
    describe "fail" do
      it "password and confirmation are not matched" do
        encrypted_password_backup = @user.encrypted_password
        page.fill_in("user[password]", :with => "new_password")
        page.fill_in("user[password_confirmation]", :with => "wrong_password")
        page.click_button(I18n.t("link.update"))
        @user.reload
        @user.encrypted_password.should == encrypted_password_backup
        page.current_path.should == update_password_user_path(@user)
        page.should have_content("Password doesn't match confirmation")
      end
    end    
  end
end
