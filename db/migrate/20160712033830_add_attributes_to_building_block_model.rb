class AddAttributesToBuildingBlockModel < ActiveRecord::Migration[5.0]
  def change
    add_column :building_blocks, :type, :string  
  end
end
