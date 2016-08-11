class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.integer :resource_id
      t.integer :attachment_type_id
      t.string :url

      t.timestamps
    end
  end
end
