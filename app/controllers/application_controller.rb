class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_sessions
  before_action :load_activities

  include PublicActivity::StoreController

  def load_activities
    if current_user
      if current_user.team?
        @team = Team.joins(:user).where(users: { userable_id: current_user.userable_id }).first
        @activities = PublicActivity::Activity.where(recipient_id: @team.user.id).order('created_at DESC').limit(5)
      elsif current_user.mentor?
        @mentor = Mentor.joins(:user).where(users: { userable_id: current_user.userable_id }).first
        @activities = PublicActivity::Activity.where(recipient_id: @mentor.user.id).order('created_at DESC').limit(5)
      end
    end
  end
end
