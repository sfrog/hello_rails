require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe "association" do
    it "should has right association" do
      team = create(:team)
      user = create(:user)
      project = create(:project, team: team)
      todo = create(:todo, project: project, creator: user)
      comment = create(:comment, user: user, commentable: todo)
      event = TodoEvent.last

      expect(todo.project).to eq(project)
      expect(todo.creator).to eq(user)
      expect(todo.comments[0]).to eq(comment)
      expect(todo.events[0]).to eq(event)
    end
  end

  describe "attributes" do
    it "should has right owner" do
      user = create(:user)
      todo = create(:todo, owner_id: user.id)

      expect(todo.owner).to eq(user)
    end
  end

  describe "state" do
    it "should been not removed and unfinished when created" do
      todo = build(:todo)

      expect(todo.removed?).to eq(false)
      expect(todo.finished?).to eq(false)
    end

    it "should been finished after finish and unfinished after unfinish" do
      todo = build(:todo)
      user = build(:user)

      todo.finish_by(user)
      expect(todo.finished?).to eq(true)

      todo.unfinish_by(user)
      expect(todo.finished?).to eq(false)
    end

    it "should been removed after remove and not removed after recover" do
      todo = build(:todo)
      user = build(:user)

      todo.remove_by(user)
      expect(todo.removed?).to eq(true)

      todo.recover_by(user)
      expect(todo.removed?).to eq(false)
    end
  end

  describe "event" do
    it "should create a TodoEvent when created" do
      todo = create(:todo)
      project = todo.project
      team = project.team
      event = TodoEvent.last

      expect(event).not_to eq(nil)
      expect(event.resource).to eq(todo)
      expect(event.action).to eq("add")
      expect(event.actor).to eq(todo.creator)
      expect(event.project).to eq(project)
      expect(event.team).to eq(team)
    end

    it "should create a TodoEvent when removed" do
      todo = build(:todo)
      user = build(:user)

      todo.remove_by(user)
      project = todo.project
      team = project.team
      event = TodoEvent.last

      expect(event).not_to eq(nil)
      expect(event.resource).to eq(todo)
      expect(event.action).to eq("remove")
      expect(event.actor).to eq(user)
      expect(event.project).to eq(project)
      expect(event.team).to eq(team)
    end

    it "should create a TodoEvent when finished" do
      todo = build(:todo)
      user = build(:user)

      todo.finish_by(user)
      project = todo.project
      team = project.team
      event = TodoEvent.last

      expect(event).not_to eq(nil)
      expect(event.resource).to eq(todo)
      expect(event.action).to eq("finish")
      expect(event.actor).to eq(user)
      expect(event.project).to eq(project)
      expect(event.team).to eq(team)
    end

    it "should create a TodoEvent when assigned" do
      todo = build(:todo)
      user = build(:user)

      # assign
      owner = create(:user)
      todo.assign_by(user, owner)
      project = todo.project
      team = project.team
      event = TodoEvent.last

      expect(todo.owner_id).to eq(owner.id)

      expect(event).not_to eq(nil)
      expect(event.resource).to eq(todo)
      expect(event.actor).to eq(user)
      expect(event.project).to eq(project)
      expect(event.team).to eq(team)
      expect(event.action).to eq("assign")
      expect(event.value).to eq(owner.id)
      expect(event.old_value).to eq(nil)

      # update assign
      new_owner = create(:user)
      old_owner_id = todo.owner_id
      todo.assign_by(user, new_owner)
      event = TodoEvent.last

      expect(todo.owner_id).to eq(new_owner.id)

      expect(event.action).to eq("update_assign")
      expect(event.value).to eq(new_owner.id)
      expect(event.old_value).to eq(old_owner_id)

      # cancel assign
      old_owner_id = todo.owner_id
      todo.assign_by(user, nil)
      event = TodoEvent.last

      expect(todo.owner_id).to eq(nil)

      expect(event.action).to eq("cancel_assign")
      expect(event.value).to eq(nil)
      expect(event.old_value).to eq(old_owner_id)
    end

    it "should create a TodoEvent when change due_at" do
      todo = build(:todo)
      user = build(:user)

      day = Date.tomorrow
      todo.change_due_by(user, day)
      project = todo.project
      team = project.team
      event = TodoEvent.last

      expect(event).not_to eq(nil)
      expect(event.resource).to eq(todo)
      expect(event.action).to eq("due")
      expect(event.actor).to eq(user)
      expect(event.project).to eq(project)
      expect(event.team).to eq(team)
      expect(event.value).to eq(day.to_s)
      expect(event.old_value).to eq(nil)
    end
  end
end
