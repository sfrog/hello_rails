class Event < ApplicationRecord
  belongs_to :actor, class_name: 'User'
  belongs_to :project
  belongs_to :team
  belongs_to :resource, polymorphic: true
end
