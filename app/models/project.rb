class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
end
