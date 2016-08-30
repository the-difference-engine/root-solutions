require 'csv'

class BuildingBlockSubstep < ApplicationRecord
  belongs_to :building_block
  has_many :resources_building_block_substeps
  has_many :resources, through: :resources_building_block_substeps

  def self.to_csv(options = {})
    desired_columns = ["name", "building_block_id"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |building_block_substep|
        csv << building_block_substep.attributes.values_at(*desired_columns)
      end
    end
  end

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      building_block_substep = find_by(name: row["name"]) || new
      building_block_substep.attributes = row.to_hash
      building_block_substep.save!
    end
  end
end
