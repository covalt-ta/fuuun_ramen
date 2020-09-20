module SignInSupport
  def sign_in_user(user)
    visit new_user_session_path
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    find("input[name='commit']").click
    expect(current_path).to eq products_path
  end

  def sign_in_admin(admin)
    visit new_admin_session_path
    fill_in "admin[email]", with: admin.email
    fill_in "admin[password]", with: admin.password
    find("input[name='commit']").click
    expect(current_path).to eq admins_root_path
  end
end
