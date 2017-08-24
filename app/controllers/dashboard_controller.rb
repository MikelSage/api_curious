class DashboardController < ApplicationController
  def index
    @user_info = GithubService.find_basic_info(current_user)
  end
end
