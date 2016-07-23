module TestingMethods
  def generate_user(email)
    new_user = User.new
    new_user.email = email
    new_user.password = '123456'
    new_user.password_confirmation = '123456'
    new_user.save!
  end

  def create_user(email)
    visit '/'
    click_link 'Sign Up'
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'
    click_button 'Sign Up'
  end

  def sign_in_user(email)
    visit '/'
    click_link 'Sign In'
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: '123456'
    click_button 'Sign In'
  end
end

RSpec.configure do |c|
  c.include TestingMethods, type: :feature
end
