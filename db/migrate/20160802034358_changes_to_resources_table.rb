class ChangesToResourcesTable < ActiveRecord::Migration[5.0]
  def change
    rename_column :resources, :notes, :admin_notes
    rename_column :resources, :summary, :abstract
    add_column :resources, :is_published, :boolean, default: false
    add_column :resources, :is_problem, :boolean

  end
end
