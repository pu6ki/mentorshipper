class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    path = if current_user.mentor?
             users_teams_path
           elsif current_user.team?
             technologies_path
           end

    redirect_to path
  end
end
