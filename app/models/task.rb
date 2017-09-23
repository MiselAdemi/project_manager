class Task < ApplicationRecord
  belongs_to :project, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  enum priority: [:low, :medium, :high]

  validates :name, presence: true
  validates :description, presence: true
  validates :priority, presence: true
  validates :deadline, presence: true
end
