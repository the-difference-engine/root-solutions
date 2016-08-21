require 'csv'

class EnvironmentalSubtag < ApplicationRecord
  has_many :resources, through: :resources_environmental_subtags
  has_many :resources_environmental_subtags

  belongs_to :environmental_tag

  def self.to_csv(options = {})
    desired_columns = ["id", "name", "environmental_tag_id"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |environmental_subtag|
        csv << environmental_subtag.attributes.values_at(*desired_columns)
      end
    end
  end

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      environmental_subtag = find_by(id: row["id"]) || new
      environmental_subtag.attributes = row.to_hash
      environmental_subtag.save!
    end
  end
end
