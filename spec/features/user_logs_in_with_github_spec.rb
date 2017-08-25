require 'rails_helper'

RSpec.feature 'User can log in with GitHub' do
  before do
    stub_omniauth
  end

  scenario 'and see their name and no longer see the login button' do
    visit root_path
    expect(page).to have_content 'Login using GitHub'
    click_on 'Login using GitHub'
    expect(page).to have_content 'MikelSage'
    expect(page).to have_link 'Logout'
    expect(page).to_not have_content 'Login using GitHub'
  end

  scenario 'and can logout' do
    visit root_path
    click_on 'Login using GitHub'
    expect(page).to have_content 'MikelSage'
    click_on 'Logout'
    expect(page).to have_content 'Login using GitHub'
    expect(page).to_not have_content 'Logout'
    expect(page).to_not have_content 'MikelSage'
  end
end
