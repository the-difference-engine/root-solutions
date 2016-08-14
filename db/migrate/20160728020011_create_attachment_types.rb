class CreateAttachmentTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :attachment_types do |t|
      t.string :attachment_type

      t.timestamps
    end
  end
end
