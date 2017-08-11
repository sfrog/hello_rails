require 'rails_helper'

RSpec.describe Team, type: :model do
  describe "association" do
    it "should has right association" do
      team = create(:team)
      user = create(:user)
      project = create(:project, team: team)
      add_todo_event = create(:add_todo_event, team: team)
      team_access = create(:team_access, user: user, accessable: team)

      expect(team.accesses[0]).to eq(team_access)
      expect(team.users[0]).to eq(user)
      expect(team.projects[0]).to eq(project)
      expect(team.events[0]).to eq(add_todo_event)
    end
  end
end
