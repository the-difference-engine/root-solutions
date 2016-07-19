class FixingResourcesSubtagsSpelling < ActiveRecord::Migration[5.0]
  def change
    rename_table :resources_subgtags, :resources_subtags
  end
end
