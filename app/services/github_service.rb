class GithubService
  def initialize(user)
    @user = user
    @conn = Faraday.new('https://api.github.com/') do |faraday|
      faraday.headers["Authorization"] = "token #{user.token}"
      faraday.adapter Faraday.default_adapter
    end
  end

  def find_basic_info
    data = get_data('/user')
    data[:starred_repos] = get_data('/user/starred').count
    data
  end

  def get_data(endpoint)
    response = @conn.get(endpoint)
    result = JSON.parse(response.body, symbolize_names: true)
  end

  def self.find_basic_info(user)
    new(user).find_basic_info
  end
end
