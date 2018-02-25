class TechnologiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @technologies = Technology.all
  end
end
