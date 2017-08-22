require 'rails_helper'

RSpec.feature 'User can log in with GitHub' do
  scenario 'and see their name and no longer see the login button' do
    stub_omniauth
    visit root_path
    expect(page).to have_content 'Login using GitHub'
    click_on 'Login using GitHub'
    expect(page).to have_content 'MikelSage'
    expect(page).to have_link 'Logout'
    expect(page).to_not have_content 'Login using GitHub'
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: "github",
      uid: '12345678',
      info: {
        nickname: 'MikelSage',
        email: 'michael@mike.com'
      },
      credentials: {
        token: "12341b21341234n2h3"
      }
      })
  end
end
