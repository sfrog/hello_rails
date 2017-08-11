class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :events, as: :resource

  after_create :send_add_event

private

  def send_add_event
    CommentEvent.createAddEvent(self)
  end
end
