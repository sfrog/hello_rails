require 'rails_helper'

RSpec.describe Access, type: :model do
  describe "association" do
    it "should has right association" do
      team = create(:team)
      user = create(:user)
      project = create(:project)

      project_access = create(:project_access, user: user, accessable: project)
      team_access = create(:team_access, user: user, accessable: team)

      expect(project_access.user).to eq(user)
      expect(project_access.accessable).to eq(project)
      expect(team_access.user).to eq(user)
      expect(team_access.accessable).to eq(team)
    end
  end
end
