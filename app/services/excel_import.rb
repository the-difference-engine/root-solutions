require 'roo'

class ExcelImport
  def initialize(file)
    @spreadsheets = Roo::Spreadsheet.open(file)
    @spread = @spreadsheets.sheet(1)
    @keys = @spreadsheets.sheet(2)
  end

  def key_import
    columns = [
      e_tag_ids = @keys.column(1),
      e_tags = @keys.column(2),
      es_tag_ids = @keys.column(3),
      es_tags = @keys.column(4),
      es_etag_ids = @keys.column(5),
      b_block_ids = @keys.column(6),
      b_blocks = @keys.column(7),
      principle_ids = @keys.column(8),
      principles = @keys.column(9),
      principle_b_block_ids = @keys.column(10),
      world_region_ids = @keys.column(11),
      world_regions = @keys.column(12),
      cog_bias_ids =  @keys.column(13),
      cog_bium = @keys.column(14),
      resource_type_ids = @keys.column(15),
      resource_types = @keys.column(16)
    ]

    columns.each do |column|
      column.slice!(0)
      column.slice!(0)
    end

    e_tag_ids.each_with_index do |e_tag_id, i|
      environmental_tag = EnvironmentTag.find_or_create_by(id: e_tag_id, name: e_tags[i])
    end

    es_tag_ids.each_with_index do |es_tag_id, i|
      environmental_sub_tag = EnvironmentSubtag.find_or_create_by(id: es_tag_id, name: es_tags[i], environmental_tag_id: es_etag_ids[i])
    end

    b_block_ids.each_with_index do |b_block_id, i|
      building_block = BuildingBlock.find_or_create_by(id: b_block_id, name: b_blocks[i])
    end

    principle_ids.each_with_index do |principle_id, i|
      principle = BuildingBlockSubstep.find_or_create_by(id: principle_id, name: principles[i], building_block_id: principle_b_block_ids[i])
    end

    world_regions_ids.each_with_index do |world_region_id, i|
      world_region = WorldRegion.find_or_create_by(id: world_region_id, name: world_regions[i])
    end

    cog_bias_ids.each_with_index do |cog_bias_id, i|
      cognitive_bias = CognitiveBias.find_or_create_by(id: cog_bias_id, name: cog_bium[i])
    end

    resource_type_ids.each_with_index do |resource_type_id, i|
      resource_type = ResourceType.find_or_create_by(id: resource_type_id, name: resource_types[i])
    end
  end

  def data_import

  end
end