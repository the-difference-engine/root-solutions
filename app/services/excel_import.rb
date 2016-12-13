require 'roo'

class ExcelImport
  def initialize(file)
    @spreadsheets = Roo::Spreadsheet.open(file)
    @spread = @spreadsheets.sheet(0)
    @keys = @spreadsheets.sheet(1)
  end

  def key_import
    columns = key_columns_setup
    create_etags(columns[0], columns[1])
    create_estags(columns[2], columns[3], columns[4])
    create_bblocks(columns[5], columns[6])
    create_principles(columns[7], columns[8], columns[9])
    create_world_regions(columns[10], columns[11])
    create_cog_bia(columns[12], columns[13])
    create_rtypes(columns[14], columns[15])
  end

  def key_columns_setup
    columns = [
      e_tag_ids = @keys.column(1),              #0. e_tag_ids
      e_tags = @keys.column(2),                 #1. e_tags
      es_tag_ids = @keys.column(3),             #2. es_tag_ids
      es_tags = @keys.column(4),                #3. es_tags
      es_etag_ids = @keys.column(5),            #4. es_etag_ids
      b_block_ids = @keys.column(6),            #5. b_block_ids
      b_blocks = @keys.column(7),               #6. b_blocks
      principle_ids = @keys.column(8),          #7. principle_ids
      principles = @keys.column(9),             #8. principles
      principle_b_block_ids = @keys.column(10), #9. principle_b_block_ids
      world_region_ids = @keys.column(11),      #10. world_region_ids
      world_regions = @keys.column(12),         #11. world_regions
      cog_bias_ids =  @keys.column(13),         #12. cog_bias_ids
      cog_bia = @keys.column(14),               #13. cog_bia
      resource_type_ids = @keys.column(15),     #14. resource_type_ids
      resource_types = @keys.column(16)         #15. resource_types
    ]
    columns.each do |column|
      column.slice!(0)
      column.slice!(0)
      column.delete(nil)
    end
    return columns
  end

  def create_etags(ids, etags)
    ids.each_with_index do |id, i|
      environmental_tag = EnvironmentalTag.find_or_create_by(id: id.to_i, name: etags[i])
    end
  end

  def create_estags(ids, estags, etag_ids)
    ids.each_with_index do |id, i|
      environmental_sub_tag = EnvironmentalSubtag.find_or_create_by(id: id.to_i, name: estags[i], environmental_tag_id: etag_ids[i])
    end
  end

  def create_bblocks(ids, bblocks)
    ids.each_with_index do |id, i|
      building_block = BuildingBlock.find_or_create_by(id: id.to_i, name: bblocks[i])
    end
  end

  def create_principles(ids, substeps, bblock_ids)
    ids.each_with_index do |id, i|
      principle = BuildingBlockSubstep.find_or_create_by(id: id.to_i, name: substeps[i], building_block_id: bblock_ids[i])
    end
  end

  def create_world_regions(ids, wregions)
    ids.each_with_index do |id, i|
      world_region = WorldRegion.find_or_create_by(id: id.to_i, name: wregions[i])
    end
  end

  def create_cog_bia(ids, cog_biases)
    ids.each_with_index do |id, i|
      cognitive_bium = CognitiveBium.find_or_create_by(id: id.to_i, name: cog_biases[i])
    end
  end

  def create_rtypes(ids, rtypes)
    ids.each_with_index do |id, i|
      resource_type = ResourceType.find_or_create_by(id: id.to_i, name: rtypes[i])
    end
  end

  def data_import

  end
end