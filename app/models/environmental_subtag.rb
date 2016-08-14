class EnvironmentalSubtag < ApplicationRecord
  has_many :resources, through: :resources_environmental_subtags
  has_many :resources_environmental_subtags

  belongs_to :environmental_tag
end
