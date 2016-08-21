require 'csv'

class BuildingBlock < ApplicationRecord
  has_many :building_block_substeps, dependent: :destroy

  def self.to_csv(options = {})
    desired_columns = ["id", "name"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |building_block|
        csv << building_block.attributes.values_at(*desired_columns)
      end
    end
  end

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      building_block = find_by(id: row["id"]) || new
      building_block.attributes = row.to_hash
      building_block.save!
    end
  end
end
