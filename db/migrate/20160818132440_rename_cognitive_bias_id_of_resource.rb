class RenameCognitiveBiasIdOfResource < ActiveRecord::Migration[5.0]
  def change
    rename_column :resources, :cognitive_bias_id, :cognitive_bium_id
  end
end
