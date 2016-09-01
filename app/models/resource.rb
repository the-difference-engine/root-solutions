class Resource < ApplicationRecord
  searchkick
  has_many :building_block_substeps, through: :resources_building_block_substeps
  has_many :resources_building_block_substeps

  has_many :environmental_subtags, through: :resources_environmental_subgtags
  has_many :resources_environmental_subtags

  has_many :resources_environmental_subtags

  belongs_to :news_source

  belongs_to :resource_type

  belongs_to :world_region

  belongs_to :cognitive_bium

  has_many :attachments

end
