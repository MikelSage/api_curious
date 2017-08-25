# frozen_string_literal: true
require 'rails_helper'

describe GithubService do
  it 'can find basic user info' do
    VCR.use_cassette('services/basic_info') do
      user = User.create(token: ENV['USER_AUTH_TOKEN'])
      url = 'https://avatars0.githubusercontent.com/u/26507085?v=4'

      data = GithubService.find_basic_info(user)

      expect(data[:login]).to eq 'MikelSage'
      expect(data[:followers]).to eq 3
      expect(data[:following]).to eq 3
      expect(data[:avatar_url]).to eq url
      expect(data[:starred_repos]).to eq 1
    end
  end

  it 'can find the 10 most recent events of a user' do
    VCR.use_cassette('services/user_recent_events') do
      user = User.create(token: ENV['USER_AUTH_TOKEN'], nickname: 'MikelSage')

      data = GithubService.find_recent_events(user)
      first = data.first
      first_author = first[:commit][:author]
      msg =
      "Merge pull request #5 from MikelSage/user-stats\n\nUser stats: Closes #4"

      expect(data.count).to eq 10
      expect(first[:author][:login]).to eq 'MikelSage'
      expect(first[:repository][:full_name]).to eq 'MikelSage/api_curious'
      expect(first_author[:date]).to eq "2017-08-24T14:30:31.000-06:00"
      expect(first[:commit][:message]).to eq msg
    end
  end
end
