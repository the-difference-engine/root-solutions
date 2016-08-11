class ChangesToResourcesTableAndJoinTablesAddBuildingBlockJoinTableEtc < ActiveRecord::Migration[5.0]
  def change
    remove_column :tags, :category_id, :integer

    rename_table :tags, :environmental_tags
    rename_table :subtags, :environmental_subtags
    rename_table :resources_subtags, :resources_environmental_subtags  

    add_column :resources, :cognitive_bias_id, :integer
    add_column :resources, :content, :text
    add_column :resources, :academic_citation, :text  

    drop_table :resources_building_blocks
    drop_table :categories
  end
end
