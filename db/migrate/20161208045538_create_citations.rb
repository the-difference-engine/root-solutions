class CreateCitations < ActiveRecord::Migration[5.0]
  def change
    create_table :citations do |t|
      t.integer :resource_id
      t.text :citation_1
      t.text :citation_2
      t.string :title
      t.string :author
      t.integer :news_source_id
      t.datetime :date
      t.string :url

      t.timestamps
    end
  end
end
