class Task < ApplicationRecord
  belongs_to :project

  enum priority: [:low, :medium, :heigh]

  validates :name, presence: true
  validates :description, presence: true
  validates :priority, presence: true
  validates :deadline, presence: true
end
