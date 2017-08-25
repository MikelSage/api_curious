class DashboardController < ApplicationController
  def index
    @user_info = GithubService.find_basic_info(current_user)
    @user_recent_events = GithubService.find_recent_events(current_user)
  end
end
