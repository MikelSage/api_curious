require 'rails_helper'

RSpec.feature 'User visits the dashboard' do
  scenario 'and sees their basic account info' do
    stub_omniauth
    VCR.use_cassette('features/user_sees_basic_info') do
      visit '/'
      click_on 'Login using GitHub'
      expect(current_path).to eq dashboard_path
      expect(page).to have_css '.profile-pic'
      expect(page).to have_content 'Your Recent Activity'
      expect(page).to have_content 'Followed Recent Activity'
      expect(page).to have_content 'Starred Repos (1)'
      expect(page).to have_content 'Followers (2)'
      expect(page).to have_content 'Following (3)'
    end
  end
end
