require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "association" do
    it "should has right association" do
      user = create(:user)
      todo = create(:todo)
      comment = create(:comment, user: user, commentable: todo)
      event = CommentEvent.last

      expect(comment.user).to eq(user)
      expect(comment.commentable).to eq(todo)
      expect(comment.events[0]).to eq(event)
    end
  end

  describe "event" do
    it "should create a CommentEvent when created" do
      comment = create(:comment)
      project = comment.commentable.project
      team = project.team
      event = CommentEvent.last

      expect(event).not_to eq(nil)
      expect(event.resource).to eq(comment)
      expect(event.action).to eq("add")
      expect(event.actor).to eq(comment.user)
      expect(event.project).to eq(project)
      expect(event.team).to eq(team)
    end
  end
end
