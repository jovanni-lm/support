require 'rails_helper'

feature 'User adds issue' do
  background do
    @issue = FactoryGirl.attributes_for(:issue)
    open_email(FactoryGirl.create(:issue).email)
  end

  scenario 'front page contains issue form' do
    visit '/'
    expect(page).to have_content('New Issue')
  end

  scenario 'with valid values' do
    visit '/'

    fill_in 'Name',                 with: @issue[:name]
    fill_in 'Email',                with: @issue[:email]
    fill_in 'Department',           with: @issue[:department]
    fill_in 'Subject',              with: @issue[:subject]
    fill_in 'Body of the request',  with: @issue[:body]
    click_button 'Create Issue'

    expect(page).to have_css('.alert-success')
  end

  scenario 'checking email notification' do
    expect(current_email).to have_content 'was successfully created'
  end

  scenario 'checking email links' do
    expect(current_email).to have_selector(:link_or_button, 'View')
    expect(current_email).to have_selector(:link_or_button, 'Edit')
    expect(current_email).to have_selector(:link_or_button, 'History')
  end
end
