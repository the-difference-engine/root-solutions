require 'csv'

class Resource < ApplicationRecord
  searchkick
  has_many :building_block_substeps, through: :resources_building_block_substeps
  has_many :resources_building_block_substeps

  has_many :environmental_subtags, through: :resources_environmental_subtags
  has_many :resources_environmental_subtags

  has_many :resources_environmental_subtags

  belongs_to :news_source

  belongs_to :resource_type

  belongs_to :world_region

  belongs_to :cognitive_bium

  has_many :attachments

  def self.import_resource(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      resource = find_by(title: row["title"]) || new
      resource.attributes = row.to_hash
    end
  end

end
