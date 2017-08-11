require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "association" do
    it "should has right association" do
      team = create(:team)
      user = create(:user)
      project = create(:project)
      todo = create(:todo)
      add_todo_event = create(:add_todo_event, actor: user, project: project, team: team, resource: todo)

      expect(add_todo_event.actor).to eq(user)
      expect(add_todo_event.project).to eq(project)
      expect(add_todo_event.team).to eq(team)
      expect(add_todo_event.resource).to eq(todo)
    end
  end

  describe "attributes" do
    it "should has right type" do
      add_todo_event = create(:add_todo_event)
      add_comment_event = create(:add_comment_event)

      expect(add_todo_event.type).to eq("TodoEvent")
      expect(add_comment_event.type).to eq("CommentEvent")
    end
  end
end
