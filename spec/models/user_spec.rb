require 'rails_helper'

RSpec.describe User, type: :model do
  describe "association" do
    it "should has right association" do
      team = create(:team)
      user = create(:user)

      team_access = create(:team_access, user: user, accessable: team)

      expect(user.accesses[0]).to eq(team_access)
      expect(user.teams[0]).to eq(team)
    end
  end
end
