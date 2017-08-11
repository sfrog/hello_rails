class User < ApplicationRecord
  has_many :accesses
  has_many :teams, through: :accesses, source: :accessable, source_type: 'Team'
end
