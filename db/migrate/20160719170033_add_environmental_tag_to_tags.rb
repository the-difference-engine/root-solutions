class AddEnvironmentalTagToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :environmental_tag, :string
  end
end
