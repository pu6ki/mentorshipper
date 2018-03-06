class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    path = if current_user.mentor?
             users_teams_path
           elsif current_user.team?
             users_team_path(current_user.userable)
           end

    redirect_to path
  end
end
