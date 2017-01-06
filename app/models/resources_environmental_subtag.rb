class ResourcesEnvironmentalSubtag < ApplicationRecord
  belongs_to :resource
  belongs_to :environmental_subtag, foreign_key: :subtag_id
end
