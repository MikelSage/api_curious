# frozen_string_literal: true

class GithubService
  def initialize(user)
    @user = user
    @conn = Faraday.new('https://api.github.com/') do |faraday|
      faraday.headers['Authorization'] = "token #{user.token}"
      faraday.headers['Accept'] = "application/vnd.github.cloak-preview"
      faraday.adapter Faraday.default_adapter
    end
  end

  def find_basic_info
    data = get_data('/user')
    data[:starred_repos] = get_data('/user/starred').count
    data
  end

  def find_recent_events
    get_data("/search/commits?q=author:#{@user.nickname}&sort=author-date&per_page=10")[:items]
  end

  def get_data(endpoint)
    response = @conn.get(endpoint)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.find_basic_info(user)
    new(user).find_basic_info
  end

  def self.find_recent_events(user)
    new(user).find_recent_events
  end
end
