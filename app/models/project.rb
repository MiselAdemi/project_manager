class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :comments, as: :commentable

  validates :name, presence: true
  validates :description, presence: true
end
