require 'csv'

class WorldRegion < ApplicationRecord
  has_many :resources

  def self.to_csv(options = {})
    desired_columns = ["name"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |world_region|
        csv << world_region.attributes.values_at(*desired_columns)
      end
    end
  end

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      world_region = find_by(name: row["name"]) || new
      world_region.attributes = row.to_hash
      world_region.save!
    end
  end
end
