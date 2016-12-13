class ChangeCitationDate < ActiveRecord::Migration[5.0]
  def change
    change_column :citations, :date, :date
  end
end
