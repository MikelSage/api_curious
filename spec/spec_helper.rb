RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

def stub_omniauth
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
    provider: "github",
    uid: '12345678',
    info: {
      nickname: 'MikelSage',
      email: 'michael@mike.com',
      image: 'https://avatars0.githubusercontent.com/u/26507085?v=4'
    },
    credentials: {
      token: ENV['USER_AUTH_TOKEN']
    }
    })
end
