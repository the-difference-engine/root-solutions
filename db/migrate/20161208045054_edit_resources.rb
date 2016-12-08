class EditResources < ActiveRecord::Migration[5.0]
  def change
    rename_column :resources, :content, :description
    add_column :resources, :is_solution, :boolean
    remove_column :resources, :admin_notes, :text
    remove_column :resources, :academic_citation, :text
  end
end
