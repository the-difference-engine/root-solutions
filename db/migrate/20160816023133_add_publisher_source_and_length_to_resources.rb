class AddPublisherSourceAndLengthToResources < ActiveRecord::Migration[5.0]
  def change
    add_column :resources, :publisher, :string
    add_column :resources, :source, :string
    add_column :resources, :length, :string
  end
end
