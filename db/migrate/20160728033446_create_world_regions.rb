class CreateWorldRegions < ActiveRecord::Migration[5.0]
  def change
    create_table :world_regions do |t|
      t.string :name

      t.timestamps null: true
    end
  end
end
