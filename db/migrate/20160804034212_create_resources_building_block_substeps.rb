class CreateResourcesBuildingBlockSubsteps < ActiveRecord::Migration[5.0]
  def change
    create_table :resources_building_block_substeps do |t|
      t.integer :building_block_substep_id
      t.integer :resource_id

      t.timestamps null: true
    end
  end
end
