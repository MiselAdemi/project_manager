class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  mount_uploaders :attachment, AttachmentUploader
  serialize :attachment, JSON

  validates :body, presence: true
end
