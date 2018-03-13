class TechnologiesController < ApplicationController
  def index
    @technologies = current_user.technologies
  end

  # def create
  #   @technology = Technology.create!(name: params[:name])
  #   render json: @technology
  # end
end
