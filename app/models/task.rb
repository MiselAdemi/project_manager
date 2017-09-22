class Task < ApplicationRecord
  belongs_to :project
  has_many :comments, as: :commentable
  
  enum priority: [:low, :medium, :high]

  validates :name, presence: true
  validates :description, presence: true
  validates :priority, presence: true
  validates :deadline, presence: true
end
