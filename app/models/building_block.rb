class BuildingBlock < ApplicationRecord
  has_many :resources, through: :resources_building_blocks
  has_many :resources_building_blocks
end
