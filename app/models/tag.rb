class Tag < ApplicationRecord
  has_many :resources, through: :resources_tags
  has_many :resources_tags

  has_many :subtags
end
