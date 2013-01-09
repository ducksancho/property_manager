module Helper
  def login(email, password)
    visit login_path
    page.fill_in "session[email]", :with => @user.email
    page.fill_in("session[password]", :with => "password")              
    page.click_button(I18n.t("link.login"))
  end
end