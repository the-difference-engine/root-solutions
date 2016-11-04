class CreateResourcesCognitiveBia < ActiveRecord::Migration[5.0]
  def change
    create_table :resources_cognitive_bia do |t|
      t.integer :resource_id
      t.integer :cognitive_bia_id

      t.timestamps
    end
  end
end