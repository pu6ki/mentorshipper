class Users::TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_mentor_user, only: [:index]
  before_action :set_team, only: [:show]

  def index
    @teams = current_user.userable.teams.all
  end

  def show
  end

  private

  def verify_mentor_user
    redirect_to sign_in_path unless current_user.mentor?
  end

  def set_team
    current_userable = current_user.userable

    @team = if current_user.team?
              current_userable
            elsif current_user.mentor?
              current_userable.teams.find_by id: params[:id]
            end
  end
end
