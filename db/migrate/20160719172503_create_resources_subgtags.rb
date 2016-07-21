class CreateResourcesSubgtags < ActiveRecord::Migration[5.0]
  def change
    create_table :resources_subgtags do |t|
      t.integer :resource_id
      t.integer :subtag_id

      t.timestamps
    end
  end
end
