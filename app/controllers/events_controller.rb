class EventsController < ApplicationController
  def index
    @team_id = params[:team_id]
    @by_member = params[:by_member] || nil
    @by_project = params[:by_project] || nil
    @offset = params[:offset] || nil
    @limit = params[:limit] || 50
    # binding.pry
    @events = Event.where('team_id = ?', @team_id)
    @events = @events.where('id < ?', @offset.to_i) if @offset.present?
    @events = @events.where('actor_id = ?', @by_member) if @by_member.present?
    @events = @events.where('project_id = ?', @by_project) if @by_project.present?
    @events = @events.order(id: :desc).limit(@limit)
    @events = @events.includes(:project, :actor, :resource)

    @team = Team.find(@team_id)
  end
end
