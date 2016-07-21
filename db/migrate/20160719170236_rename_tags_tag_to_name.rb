class RenameTagsTagToName < ActiveRecord::Migration[5.0]
  def change
    rename_column :tags, :tag, :name
  end
end
