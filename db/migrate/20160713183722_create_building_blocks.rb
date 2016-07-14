class CreateBuildingBlocks < ActiveRecord::Migration[5.0]
  def change
    create_table :building_blocks do |t|
      t.string :building_block

      t.timestamps
    end
  end
end
