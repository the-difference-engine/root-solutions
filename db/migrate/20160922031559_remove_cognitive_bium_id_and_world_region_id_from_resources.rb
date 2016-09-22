class RemoveCognitiveBiumIdAndWorldRegionIdFromResources < ActiveRecord::Migration[5.0]
  def change
    remove_column :resources, :cognitive_bium_id, :integer
    remove_column :resources, :world_region_id, :integer
  end
end
