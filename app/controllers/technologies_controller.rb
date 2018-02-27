class TechnologiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @technologies = current_user.technologies
  end
end
