class AddIndexToResourcesBuildingBlocks < ActiveRecord::Migration[5.0]
  def change
    add_index :resources_building_blocks, :resource_id
    add_index :resources_building_blocks, :building_block_id
  end
end
