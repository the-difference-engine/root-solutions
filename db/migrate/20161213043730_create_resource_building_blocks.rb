class CreateResourceBuildingBlocks < ActiveRecord::Migration[5.0]
  def change
    create_table :resource_building_blocks do |t|
      t.integer :resource_id
      t.integer :building_block_id

      t.timestamps
    end
  end
end
