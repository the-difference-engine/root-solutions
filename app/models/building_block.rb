class BuildingBlock < ApplicationRecord
  has_many :building_block_substeps, dependent: :destroy
end
