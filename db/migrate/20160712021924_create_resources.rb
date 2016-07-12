class CreateResources < ActiveRecord::Migration[5.0]
  def change
    create_table :resources do |t|
      t.string :world_region
      t.string :title
      t.string :author
      t.string :news_source
      t.date :date
      t.text :summary
      t.string :url
      t.text :notes

      t.timestamps null: true
    end
  end
end
