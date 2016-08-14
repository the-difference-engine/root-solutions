class CreateNewsSources < ActiveRecord::Migration[5.0]
  def change
    create_table :news_sources do |t|
      t.string :name

      t.timestamps null: true
    end
  end
end
