require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "association" do
    it "should has right association" do
      team = create(:team)
      user = create(:user)
      project = create(:project, team: team)

      project_access = create(:project_access, user: user, accessable: project)

      expect(project.team).to eq(team)
      expect(project.accesses[0]).to eq(project_access)
      expect(project.users[0]).to eq(user)
    end
  end
end
