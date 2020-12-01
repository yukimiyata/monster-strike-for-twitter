module LoginMacro
  def login(user, password='password')
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: password
    click_button 'ログイン'
  end

  def logout(user)
    visit edit_user_path(user)
    click_on 'logout-button'
  end
end