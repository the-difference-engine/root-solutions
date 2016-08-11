class BuildingBlockSubstep < ApplicationRecord
  belongs_to :building_block
  has_many :resources_building_block_substeps
  has_many :resources, through: :resources_building_block_substeps
end
