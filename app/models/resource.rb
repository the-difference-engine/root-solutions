class Resource < ApplicationRecord
  
  has_many :building_blocks, through: :resources_building_blocks
  has_many :resources_building_blocks

  has_many :subtags, through: :resources_subgtags
  has_many :resources_subtags

  belongs_to :news_source
  
  belongs_to :resource_type
  
  belongs_to :world_region

end
