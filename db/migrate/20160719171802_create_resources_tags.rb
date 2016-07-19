class CreateResourcesTags < ActiveRecord::Migration[5.0]
  def change
    create_table :resources_tags do |t|

      t.timestamps
    end
  end
end
