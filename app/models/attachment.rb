class Attachment < ApplicationRecord
  belongs_to :resource
  has_one :attachment_type

  mount_uploader :url, AttachmentUploader
end
