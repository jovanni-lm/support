require 'rails_helper'

feature 'Staff actions' do
  background do
    @staff  = FactoryGirl.create(:staff)
    @issues = FactoryGirl.create_list(:issue, 10)
  end

  scenario 'staff login to the system' do
    login_staff(@staff)

    expect(page).to have_content('Issues')
  end

  scenario 'entering reference number into a search field' do
    login_staff(@staff)
    fill_in 'filterrific_search_query', with: @issues.first.task_id
    click_button 'Filter'

    expect(page).to have_content("Issue #{@issues.first.subject}")
  end

  scenario 'reply to the ticket' do
    login_staff(@staff)
    answer = 'testing answer'
    visit "issues/#{@issues.first.task_id}"

    fill_in 'Answer', with: answer
    select @staff.username, from: 'Staff'
    click_button 'Submit'

    expect(page).to have_select('issue_staff_id', selected: @staff.username)
    expect(page).to have_content(answer)

    open_email(@issues.first.email)
    expect(current_email).to have_content 'was replied'
  end

  scenario 'tracking changes to the status and owner' do
    login_staff(@staff)
    visit "issues/#{@issues.first.task_id}"
    select 'Completed', from: 'Status'
    click_button 'Submit'

    click_link('History')

    save_and_open_page

    expect(page).to have_content('Completed')
  end
end
