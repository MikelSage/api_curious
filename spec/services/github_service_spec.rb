require 'rails_helper'

describe GithubService do
  it "can find basic user info" do
    VCR.use_cassette('services/basic_info') do
      user = User.create({token: ENV["USER_AUTH_TOKEN"]})

      data = GithubService.find_basic_info(user)

      expect(data[:login]).to eq 'MikelSage'
      expect(data[:followers]).to eq 2
      expect(data[:following]).to eq 3
      expect(data[:avatar_url]).to eq "https://avatars0.githubusercontent.com/u/26507085?v=4"
      expect(data[:starred_repos]).to eq 1
    end
  end
end
