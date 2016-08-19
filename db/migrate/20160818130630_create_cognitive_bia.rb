class CreateCognitiveBia < ActiveRecord::Migration[5.0]
  def change
    create_table :cognitive_bia do |t|
      t.string :name

      t.timestamps null: true
    end
  end
end
