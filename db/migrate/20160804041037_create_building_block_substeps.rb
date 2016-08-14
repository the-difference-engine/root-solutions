class CreateBuildingBlockSubsteps < ActiveRecord::Migration[5.0]
  def change
    create_table :building_block_substeps do |t|
      t.string :name
      t.integer :building_block_id

      t.timestamps null: true
    end
  end
end
