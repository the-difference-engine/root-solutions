class AddIndexingForResourcesSubtags < ActiveRecord::Migration[5.0]
  def change
    add_index :resources_subtags, :resource_id
    add_index :resources_subtags, :subtag_id
  end
end
