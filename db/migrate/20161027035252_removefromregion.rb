class Removefromregion < ActiveRecord::Migration[5.0]
  def change
    remove_column :resources, :cognitive_bium_id, :string
    remove_column :resources, :world_region_id, :string
    rename_column :resources_cognitive_bia, :cognitive_bia_id, :cognitive_bium_id
  end
end
