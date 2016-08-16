class RenameTagIdToEnvironmentalTagId < ActiveRecord::Migration[5.0]
  def change
    rename_column :environmental_subtags, :tag_id, :environmental_tag_id
  end
end
