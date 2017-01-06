require 'csv'

class CognitiveBium < ApplicationRecord
  has_many :resources_cognitive_bia
  has_many :resources, through: :resources_cognitive_bia

  def self.to_csv(options = {})
    desired_columns = ["name"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      all.each do |problem|
        csv << problem.attributes.values_at(*desired_columns)
      end
    end
  end

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      problem = find_by(name: row["name"]) || new
      problem.attributes = row.to_hash
      problem.save!
    end
  end
end
