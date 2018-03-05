class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  protect_from_forgery with: :null_sessions

  before_action :load_activities

  def load_activities
    if current_user
      @activities = PublicActivity::Activity
                    .where(recipient_id: current_user.id)
                    .order(created_at: :desc)
                    .limit(5)
    end

    nil
  end
end
