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
      @keys.column(1),  #0. e_tag_ids
      @keys.column(2),  #1. e_tags
      @keys.column(3),  #2. es_tag_ids
      @keys.column(4),  #3. es_tags
      @keys.column(5),  #4. es_etag_ids
      @keys.column(6),  #5. b_block_ids
      @keys.column(7),  #6. b_blocks
      @keys.column(8),  #7. principle_ids
      @keys.column(9),  #8. principles
      @keys.column(10), #9. principle_b_block_ids
      @keys.column(11), #10. world_region_ids
      @keys.column(12), #11. world_regions
      @keys.column(13), #12. cog_bias_ids
      @keys.column(14), #13. cog_bia
      @keys.column(15), #14. resource_type_ids
      @keys.column(16)  #15. resource_types
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

  def data_import]
    columns = data_setup
    columns[0].each_with_index do |resource_id, index|
      if resource_id != nil
        news_source = create_news_source(columns[20][index])
        resource_input = {
          id: resource_id.to_i,
          is_published: columns[1][index],
          resource_type_id: columns[3][index].to_i,
          is_problem: columns[4][index],
          is_solution: columns[5][index],
          title: columns[18][index],
          author: columns[19][index],
          news_source_id: news_source.id,
          abstract: columns[22][index],
          url: columns[23][index],
          description: columns[24][index]
        }
        resource = create_resource(resource_input)
        create_r_cognitive_bias(columns[7][index], resource.id)
        create_r_building_block(columns[9][index], resource.id)
        create_r_substep(columns[11][index], resource.id)
        create_r_environmental_tag(columns[13][index], resource.id)
        create_r_subtag(columns[15][index], resource.id)
        create_r_world_region(columns[17][index], resource.id)
        add_object_date(columns[21][index], resource)
        citation_input = {
          citation_1: columns[25][index],
          citation_2: columns[26][index],
          title: columns[27][index],
          author: columns[28][index],
          url: columns[31][index],
          news_source: columns[29][index],
          date: columns[30][index]
        }
        create_citation(citation_input, resource.id)
      else
        break
      end
    end
  end

  def create_news_source(news_source_name)
    news_source = NewsSource.find_or_create_by(
      name: news_source_name
    )
    return news_source
  end

  def create_resource(input_hash)
    resource = Resource.find_or_create_by(
      id: input_hash[:id],
      is_published: input_hash[:is_published],
      resource_type_id: input_hash[:resource_type_id],
      is_problem: input_hash[:is_problem],
      is_solution: input_hash[:is_solution],
      title: input_hash[:title],
      author: input_hash[:author],
      news_source_id: input_hash[:news_source_id],
      abstract: input_hash[:abstract],
      url: input_hash[:url],
      description: input_hash[:description]
    )
    return resource
  end

  def create_r_cognitive_bias(cognitive_bias_id, resource_id)
    if cognitive_bias_id != nil
      if cognitive_bias_id.include?(',')
        ids = cognitive_bias_id.split(', ')
        ids.each do |id|
          resources_cog_bium = ResourcesCognitiveBium.find_or_create_by(
            resource_id: resource_id,
            cognitive_bium_id: id.to_i
          )
        end
      else
        resources_cog_bium = ResourcesCognitiveBium.find_or_create_by(
          resource_id: resource.id,
          cognitive_bium_id: cognitive_bias_id.to_i
        )
      end
    end
  end

  def create_r_building_block(building_block_id, resource_id)
    if building_block_id != nil
      if building_block_id.include?(',')
        ids = building_block_id.split(', ')
        ids.each do |id|
          resource_bb = ResourceBuildingBlock.find_or_create_by(
            resource_id: resource_id,
            building_block_id: id.to_i
          )
        end
      else
        resource_bb = ResourceBuildingBlock.find_or_create_by(
          resource_id: resource_id,
          building_block_id: building_block_id.to_i
        )
      end
    end
  end

  def create_r_substep(substep_id, resource_id)
    if substep_id != nil
      if substep_id.include?(',')
        ids = substep_id.split(', ')
        ids.each do |id|
          resources_bb_substep = ResourcesBuildingBlockSubstep.find_or_create_by(
            resource_id: resource_id,
            building_block_substep_id: id.to_i
          )
        end
      else
        resources_bb_substep = ResourcesBuildingBlockSubstep.find_or_create_by(
          resource_id: resource_id,
          building_block_substep_id: substep_id.to_i
        )
      end
    end
  end

  def create_r_environmental_tag(environmental_tag_id, resource_id)
    if environmental_tag_id != nil
      if environmental_tag_id.include?(',')
        ids = environmental_tag_id.split(',')
        ids.each do |id|
          resources_etag = ResourcesEnvironmentalTag.find_or_create_by(
            resource_id: resource_id,
            environmental_tag_id: id.to_i
          )
        end
      else
        resources_etag = ResourcesEnvironmentalTag.find_or_create_by(
          resource_id: resource_id,
          environmental_tag_id: environmental_tag_id.to_i
        )
      end
    end
  end

  def create_r_subtag(subtag_id, resource_id)
    if subtag_id != nil
      if subtag_id.include?(',')
        ids = subtag_id.split(',')
        ids.each do |id|
          resources_esubtag = ResourcesEnvionmentalSubtag.find_or_create_by(
            resource_id: resource_id,
            subtag_id: id.to_i
          )
        end
      else
        resources_esubtag = ResourcesEnvionmentalSubtag.find_or_create_by(
          resource_id: resource_id,
          subtag_id: subtag_id.to_i
        )
      end
    end
  end

  def create_r_world_region(world_region_id, resource_id)
    if world_region_id != nil
      if world_region_id.include?(',')
        ids = world_region_id.split(', ')
        ids.each do |id|
          resources_world_region = ResourcesWorldRegion.find_or_create_by(
            resource_id: resource_id,
            world_region_id: id.to_i
          )
        end
      else
        resources_world_region = ResourcesWorldRegion.find_or_create_by(
          resource_id: resource_id,
          world_region_id: world_region_id.to_i
        )
      end
    end
  end

  def add_object_date(input_date, input_resource)
    object = input_resource
    if input_date.is_a? Date
      object.assign_attributes(date: input_date)
    elsif input_date != nil
      object.assign_attributes(date: Date.new(input_date))
    end
    object.save
  end

  def create_citation(citation_hash, resource_id)
    citation_hash.each_with_index do |key, value, i|
      if i == 5
        create_citation_news_source(resource_id, value)
      elsif i == 6
        create_citation_date(resource_id, value)
      else
        create_citation_generic(resource_id, key, value)
      end
    end
  end

  def create_citation_generic(resource_id, attribute, data)
    if data != nil
      citation = Citation.find_or_create_by(resource_id: resource_id)
      citation.assign_attributes(attribute => data)
      citation.save
    end
  end

  def create_citation_news_source(resource_id, data)
    if resource_id != nil
      citation = find_or_create_by(resource_id: resource_id)
      news_source = create_news_source(resource_id)
      citation.assign_attributes(news_source_id: news_source.id)
      citation.save
    end
  end

  def create_citation_date(resource_id, data)
    if data != nil
      citation = find_or_create_by(resource_id: resource_id)
      add_object_date(data, citation)
    end
  end
  

  def create_citation_1(citation_1_input)
    if citation_hash[:citation_1] != nil
      citation = Citation.find_or_create_by(resource_id: citation_hash[:resource_id])
      citation.assign_attributes(citation_1: citation_hash[:citation_1])
      citation.save
    end
  end

    if citation_hash[:citation_2] != nil
      citation = find_or_create_by(resource_id: citation_hash[:resource_id])
      citation.assign_attributes(citation_2: citation_hash[:citation_2])
      citation.save
    end

    if citation_hash[:pop_title] != nil
      citation = find_or_create_by(resource_id: citation_hash[:resource_id])
      citation.assign_attributes(title: citation_hash[:pop_title])
      citation.save
    end

    if citation_hash[:pop_author] != nil
      citation = find_or_create_by(resource_id: resource.id)
      citation.assign_attributes(author: citation_hash[:pop_author])
      citation.save
    end



    if citation_hash[:pop_url] != nil
      citation = find_or_create_by(resource_id: citation_hash[:resource_id])
      citation.assign_attributes(url: citation_hash[:pop_url])
      citation.save
    end
  end

  def data_setup
    columns = [
      @spread.column(1),  #0. resource_id
      @spread.column(2),  #1. is_published
      @spread.column(3),  #2. resource_type
      @spread.column(4),  #3. resource_type_id
      @spread.column(5),  #4. is_problem
      @spread.column(6),  #5. is_solution
      @spread.column(7),  #6. cognitive_bias
      @spread.column(8),  #7. cognitive_bias_id
      @spread.column(9),  #8. building_block
      @spread.column(10), #9. building_block_id
      @spread.column(11), #10. principle
      @spread.column(12), #11. principle_id
      @spread.column(13), #12. environmental_tag
      @spread.column(14), #13. environmental_tag_id
      @spread.column(15), #14. environmental_subtag
      @spread.column(16), #15. environmental_subtag_id
      @spread.column(17), #16. world_region
      @spread.column(18), #17. world_region_id
      @spread.column(19), #18. title
      @spread.column(20), #19. author
      @spread.column(21), #20. news_source
      @spread.column(22), #21. date
      @spread.column(23), #22. abstract
      @spread.column(24), #23. url
      @spread.column(25), #24. case_study
      @spread.column(26), #25. academic_citation_1
      @spread.column(27), #26. academic_citation_2
      @spread.column(28), #27. popular_article_title
      @spread.column(29), #28. popular_article_author
      @spread.column(30), #29. popular_article_news_source
      @spread.column(31), #30. popular_article_date
      @spread.column(32)  #31. popular_article_url
    ]
    columns.each do |column|
      column.slice!(0)
    end
  end
end