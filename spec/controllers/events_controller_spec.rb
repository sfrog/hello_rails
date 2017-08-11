require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  before(:all) do
    @team = create(:team)
    @jason = create(:user)
    @ashley = create(:user)
    @feature_project = create(:project, team: @team)
    @bugfix_project = create(:project, team: @team)

    @todo_jason_feature = create(:todo, creator: @jason, project: @feature_project)
    @todo_event_jason_feature = TodoEvent.last
    @comment_ashley_feature = create(:comment, user: @ashley, commentable: @todo_jason_feature)
    @comment_event_ashley_feature = CommentEvent.last

    @todo_ashley_bugfix = create(:todo, creator: @ashley, project: @bugfix_project)
    @todo_event_ashley_bugfix = TodoEvent.last
    @comment_jason_bugfix = create(:comment, user: @jason, commentable: @todo_ashley_bugfix)
    @comment_event_jason_bugfix = CommentEvent.last
  end

  let(:get_vars) do
    {
      team: controller.instance_variable_get(:@team),
      events: controller.instance_variable_get(:@events),
      by_member: controller.instance_variable_get(:@by_member),
      by_project: controller.instance_variable_get(:@by_project),
      offset: controller.instance_variable_get(:@offset),
      limit: controller.instance_variable_get(:@limit)
    }
  end

  describe "GET #index" do
    it "should returns http success" do
      get :index, params: { team_id: @team.id }

      expect(response).to have_http_status(:success)
    end

    it "request all events" do
      get :index, params: { team_id: @team.id }

      vars = get_vars

      expect(vars[:team]).to eq(@team)
      expect(vars[:events].to_a).to eq([
        @comment_event_jason_bugfix,
        @todo_event_ashley_bugfix,
        @comment_event_ashley_feature,
        @todo_event_jason_feature
      ])
      expect(vars[:by_member]).to eq(nil)
      expect(vars[:by_project]).to eq(nil)
      expect(vars[:offset]).to eq(nil)
      expect(vars[:limit]).to eq(50)
    end

    it "request with offset" do
      offset = @todo_event_ashley_bugfix.id
      get :index, params: { team_id: @team.id, offset: offset }

      vars = get_vars

      expect(vars[:events].to_a).to eq([
        @comment_event_ashley_feature,
        @todo_event_jason_feature
      ])
      expect(vars[:by_member]).to eq(nil)
      expect(vars[:by_project]).to eq(nil)
      expect(vars[:offset].to_i).to eq(offset)
      expect(vars[:limit]).to eq(50)
    end

    it "request with limit" do
      limit = 3
      get :index, params: { team_id: @team.id, limit: limit }

      vars = get_vars

      expect(vars[:events].to_a).to eq([
        @comment_event_jason_bugfix,
        @todo_event_ashley_bugfix,
        @comment_event_ashley_feature
      ])
      expect(vars[:by_member]).to eq(nil)
      expect(vars[:by_project]).to eq(nil)
      expect(vars[:offset]).to eq(nil)
      expect(vars[:limit].to_i).to eq(limit)
    end

    it "request by_member" do
      by_member = @jason.id
      get :index, params: { team_id: @team.id, by_member: by_member }

      vars = get_vars

      expect(vars[:events].to_a).to eq([
        @comment_event_jason_bugfix,
        @todo_event_jason_feature
      ])
      expect(vars[:by_member]).to eq(by_member)
      expect(vars[:by_project]).to eq(nil)
      expect(vars[:offset]).to eq(nil)
      expect(vars[:limit]).to eq(50)
    end

    it "request by_project" do
      by_project = @feature_project.id
      get :index, params: { team_id: @team.id, by_project: by_project }

      vars = get_vars

      expect(vars[:events].to_a).to eq([
        @comment_event_ashley_feature,
        @todo_event_jason_feature
      ])
      expect(vars[:by_member]).to eq(nil)
      expect(vars[:by_project]).to eq(by_project)
      expect(vars[:offset]).to eq(nil)
      expect(vars[:limit]).to eq(50)
    end

    it "request by_member and by_project" do
      by_member = @ashley.id
      by_project = @bugfix_project.id
      get :index, params: { team_id: @team.id, by_project: by_project, by_member: by_member }

      vars = get_vars

      expect(vars[:events].to_a).to eq([
        @todo_event_ashley_bugfix
      ])
      expect(vars[:by_member]).to eq(by_member)
      expect(vars[:by_project]).to eq(by_project)
      expect(vars[:offset]).to eq(nil)
      expect(vars[:limit]).to eq(50)
    end
  end

end
