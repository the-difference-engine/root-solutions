class DropResourceTagsTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :resources_tags
  end
end
