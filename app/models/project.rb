class Project < ApplicationRecord
  belongs_to :team
  has_many :accesses, as: :accessable
  has_many :users, through: :accesses
end
