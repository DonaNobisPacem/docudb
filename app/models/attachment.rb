class Attachment < ActiveRecord::Base
  belongs_to :document
  validates :document, presence: true

  validates :attachment, presence: true
  mount_uploader :attachment, AttachmentUploader
end
