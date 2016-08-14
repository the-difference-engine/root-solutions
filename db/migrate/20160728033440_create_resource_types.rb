class CreateResourceTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :resource_types do |t|
      t.string :name

      t.timestamps null: true
    end
  end
end
