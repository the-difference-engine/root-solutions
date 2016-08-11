class AssociationsForTagsSubtagsResourcesTables < ActiveRecord::Migration[5.0]
  def change
    # tags table
    remove_column :tags, :environmental_tag, :string
    add_column :tags, :category_id, :integer
    # subtags table
    add_column :subtags, :tag_id, :integer
    # resources table
    remove_column :resources, :world_region, :string
    add_column :resources, :world_region_id, :integer
    remove_column :resources, :news_source, :string
    add_column :resources, :news_source_id, :integer
    add_column :resources, :resource_type_id, :integer
  end
end
