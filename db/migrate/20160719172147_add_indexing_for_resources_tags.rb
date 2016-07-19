class AddIndexingForResourcesTags < ActiveRecord::Migration[5.0]
  def change
    add_index :resources_tags, :resource_id
    add_index :resources_tags, :tag_id
  end
end
