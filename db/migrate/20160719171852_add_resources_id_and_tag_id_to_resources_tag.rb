class AddResourcesIdAndTagIdToResourcesTag < ActiveRecord::Migration[5.0]
  def change
    add_column :resources_tags, :resource_id, :integer
    add_column :resources_tags, :tag_id, :integer
  end
end
