class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  before_create :setup_id, unless: :has_normal_id?

private

  def setup_id
    self.id = SecureRandom.uuid.remove('-')
  end

  def has_normal_id?
    %w[ Event TodoEvent CommentEvent ].include?(self.class.name)
  end
end
