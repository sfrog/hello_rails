class WelcomeController < ApplicationController
  def index
    @team = Team.first
  end
end
