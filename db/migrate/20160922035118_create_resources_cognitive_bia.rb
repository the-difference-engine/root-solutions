class CreateResourcesCognitiveBia < ActiveRecord::Migration[5.0]
  def change
    create_table :resources_cognitive_bia do |t|
      t.integer :cognitive_bium_id
      t.integer :resource_id

      t.timestamps null: true
    end
  end
end
