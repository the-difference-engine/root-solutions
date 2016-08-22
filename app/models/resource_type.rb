require 'csv'

class ResourceType < ApplicationRecord
  has_many :resources

  def self.to_csv(options = {})
    desired_columns = ["name"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |resource_type|
        csv << resource_type.attributes.values_at(*desired_columns)
      end
    end
  end

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      resource_type = find_by(name: row["name"]) || new
      resource_type.attributes = row.to_hash
      resource_type.save!
    end
  end
end
