require 'rails_helper'

RSpec.feature 'User visits the dashboard' do
  before do
    stub_omniauth
  end

  scenario 'and sees their basic account info' do
    VCR.use_cassette('features/user_sees_basic_info') do
      visit '/'
      click_on 'Login using GitHub'
      expect(current_path).to eq dashboard_path
      expect(page).to have_css '.profile-pic'
      expect(page).to have_content 'Your Recent Activity'
      expect(page).to have_content 'Followed Recent Activity'
      expect(page).to have_content 'Starred Repos (1)'
      expect(page).to have_content 'Followers (3)'
      expect(page).to have_content 'Following (3)'
    end
  end

  scenario 'and sees their last 10 commits' do
    visit '/'
    click_on 'Login using GitHub'

    msg =
    "Merge pull request #5 from MikelSage/user-stats\n\nUser stats: Closes #4"

    within('.user-recent-activity') do
      expect(page).to have_content 'MikelSage/api_curious'
      expect(page).to have_content '2017-08-24'
      expect(page).to have_content msg
    end
  end
end
