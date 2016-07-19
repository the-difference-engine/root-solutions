class AddIDsToResourcesBuildingBlocksJoinTable < ActiveRecord::Migration[5.0]
  def change
    add_column :resources_building_blocks, :resource_id, :integer
    add_column :resources_building_blocks, :building_block_id, :integer
  end
end
