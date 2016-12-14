class CreateResourcesEnvironmentalTags < ActiveRecord::Migration[5.0]
  def change
    create_table :resources_environmental_tags do |t|
      t.integer :resource_id
      t.integer :environmental_tag_id

      t.timestamps
    end
  end
end
