class Team < ApplicationRecord
  has_many :events
  has_many :accesses, as: :accessable
  has_many :users, through: :accesses
  has_many :projects
end
