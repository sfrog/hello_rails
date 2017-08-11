class CommentEvent < Event
  belongs_to :resource, -> { includes :commentable }, polymorphic: true

  def self.createAddEvent(comment)
    project = comment.commentable.project
    team = project.team
    create(actor: comment.user, resource: comment, project: project, team: team,
      action: 'add')
  end

  alias_method :comment, :resource
  delegate :commentable, to: :comment

  def cache_key
    key = [super]
    key << comment.updated_at.utc.to_s(:usec)
    key << commentable.updated_at.utc.to_s(:usec)
    key << actor.updated_at.utc.to_s(:usec)
    key << project.updated_at.utc.to_s(:usec)
    key.join('/')
  end

end