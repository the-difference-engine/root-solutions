class RenameBuildingBlockToName < ActiveRecord::Migration[5.0]
  def change
    rename_column :building_blocks, :building_block, :name
  end
end
