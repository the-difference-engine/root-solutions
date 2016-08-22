require 'csv'

class EnvironmentalTag < ApplicationRecord
  has_many :environmental_subtags, dependent: :destroy

  def self.to_csv(options = {})
    desired_columns = ["name"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |environmental_tag|
        csv << environmental_tag.attributes.values_at(*desired_columns)
      end
    end
  end

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      environmental_tag = find_by(name: row["name"]) || new
      environmental_tag.attributes = row.to_hash
      environmental_tag.save!
    end
  end

end
