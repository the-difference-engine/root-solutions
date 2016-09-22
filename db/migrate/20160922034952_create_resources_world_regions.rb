class CreateResourcesWorldRegions < ActiveRecord::Migration[5.0]
  def change
    create_table :resources_world_regions do |t|
      t.integer :world_region_id
      t.integer :resource_id

      t.timestamps
    end
  end
end
