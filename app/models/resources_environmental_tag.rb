class ResourcesEnvironmentalTag < ApplicationRecord
  belongs_to :resource
  belongs_to :environmental_tag
end
