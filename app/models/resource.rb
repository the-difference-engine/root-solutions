class Resource < ApplicationRecord
  has_many :building_blocks, through: :resources_building_blocks
  has_many :resources_building_blocks

  has_many :attachments

  has_many :tags, through: :resources_tags
  has_many :resources_tags

  has_many :subtags, through: :resources_subgtags
  has_many :resources_subtags
end
