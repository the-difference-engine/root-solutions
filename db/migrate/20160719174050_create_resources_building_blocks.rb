class CreateResourcesBuildingBlocks < ActiveRecord::Migration[5.0]
  def change
    create_table :resources_building_blocks do |t|

      t.timestamps
    end
  end
end
