require 'csv'

class Resource < ApplicationRecord
  # searchkick
  has_many :resources_building_block_substeps
  has_many :building_block_substeps, through: :resources_building_block_substeps

  has_many :resources_environmental_subtags
  has_many :environmental_subtags, through: :resources_environmental_subtags

  belongs_to :news_source

  has_many :resources_cognitive_bia
  has_many :cognitive_bia, through: :resources_cognitive_bia

  has_many :resource_world_regions
  has_many :world_regions, through: :resources_world_regions

  has_many :attachments

  has_one :citation

  has_many :resource_building_blocks
  has_many :building_blocks, through: :resource_building_blocks

  has_many :resources_environmental_tags
  has_many :environmental_tags, through: :resources_environmental_tags

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
