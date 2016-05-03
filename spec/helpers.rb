module Helpers
  def new_issue
    visit '/'
    @issue = FactoryGirl.build(:issue)
    fill_in 'Name', with: name
    fill_in 'Email', with: email
    fill_in 'Department', with: password
    fill_in 'Subject', with: password
    fill_in 'Body of the request', with: password
    click_button 'Create Issue'
  end

  def login_staff(staff)
    visit 'staffs/sign_in'
    fill_in 'Login',    with: staff.username
    fill_in 'Password', with: staff.password
    click_button 'Log in'
  end
end
