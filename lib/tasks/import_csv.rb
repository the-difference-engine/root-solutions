require 'csv'
  task :import_csv do
    # For the popular article tab
    csv = CSV.foreach('/Users/Andrew_Wei/Downloads/master_grabber_popular_article.csv', :headers => true) do |row|

      if row[0] == "Yes"
        is_published = true
      else
        is_published = false
      end
      if row[1] == "Problem"
        is_problem = true
      else
        is_problem = false
      end
      building_block = row[2]
      building_block_substep = row[3]
      environmental_tag = row[4]
      environmental_subtag = row[5]
      world_region = row[6]
      title = row[7]
      author = row[8]
      news_source = row[9]
      date = row[10]
      summary = row[11]
      url = row[12]
      admin_notes = row[13]
      resource_type = "Popular Article"

    # Skipped atm: cognitive bia

      if !BuildingBlock.where(name: building_block)
        BuildingBlock.create(name: building_block)
      end

      if !BuildingBlockSubstep.where(name: building_block_substep, building_block_id: BuildingBlock.where(name: building_block).id)
        BuildingBlockSubstep.create(name: building_block_substep, building_block_id: BuildingBlock.where(name: building_block).id)
      end

      if !EnvironmentalTag.where(name: environmental_tag)
        EnvironmentalTag.create(name: environmental_tag)
      end

      if !EnvironmentalSubtag.where(name: environmental_subtag, tag_id: EnvironmentalTag.where(name: environmental_tag).id)
        EnvironmentalSubTag.create(name: environmental_subtag, tag_id: EnvironmentalTag.where(name: environmental_tag).id)
      end

      if !NewsSource.where(name: news_source)
        NewsSource.create(name: news_source)
      end

      if !WorldRegion.where(name: world_region)
        WorldRegion.create(name: world_region)
      end

      if !ResourceType.where(name: resource_type)
        new_resource_type = ResourceType.new(name: resource_type)
        new_resource_type.save
      end

      new_resource = Resource.new(is_published: is_published, title: title, author: author, date: date, abstract: summary, url: url, admin_notes: admin_notes, world_region_id: WorldRegion.where(name: world_region).id, news_source_id: NewsSource.where(name: news_source).id, resource_type_id: new_resource_type.id, is_problem: is_problem)
      # "cognitive_bias_id"
      # "content"
      # "academic_citation"
      new_resource.save

      ResourcesBuildingBlockSubstep.create(building_block_substep_id: BuildingBlockSubstep.where(name: building_block_substep, building_block_id: BuildingBlock.where(name: building_block).id).id, resource_id: new_resource.id)

      ResourcesEnvironmentalSubtag.create(resource_id: new_resource.id, subtag_id: EnvironmentalSubtag.where(name: environmental_subtag, tag_id: EnvironmentalTag.where(name: environmental_tag).id).id)
    end



    # For the academic article tab
    csv2 = CSV.foreach('/Users/Andrew_Wei/Downloads/master_grabber_academic_article.csv', :headers => true) do |row|

      if row[0] == "Yes"
        is_published = true
      else
        is_published = false
      end
      if row[1] == "Problem"
        is_problem = true
      else
        is_problem = false
      end
      building_block = row[2]
      building_block_substep = row[3]
      environmental_tag = row[4]
      environmental_subtag = row[5]
      world_region = row[6]
      title = row[7]
      author = row[8]
      publisher = row[9]
      date = row[10]
      abstract = row[11]
      url = row[12]
      admin_notes = row[13]
      resource_type = "Academic Article"

    # Skipped atm: cognitive bia

      if !BuildingBlock.where(name: building_block)
        BuildingBlock.create(name: building_block)
      end

      if !BuildingBlockSubstep.where(name: building_block_substep, building_block_id: BuildingBlock.where(name: building_block).id)
        BuildingBlockSubstep.create(name: building_block_substep, building_block_id: BuildingBlock.where(name: building_block).id)
      end

      if !EnvironmentalTag.where(name: environmental_tag)
        EnvironmentalTag.create(name: environmental_tag)
      end

      if !EnvironmentalSubtag.where(name: environmental_subtag, tag_id: EnvironmentalTag.where(name: environmental_tag).id)
        EnvironmentalSubTag.create(name: environmental_subtag, tag_id: EnvironmentalTag.where(name: environmental_tag).id)
      end

      if !WorldRegion.where(name: world_region)
        WorldRegion.create(name: world_region)
      end

      if !ResourceType.where(name: resource_type)
        new_resource_type = ResourceType.new(name: resource_type)
        new_resource_type.save
      end

      new_resource = Resource.new(is_published: is_published, title: title, author: author, date: date, abstract: abstract, url: url, admin_notes: admin_notes, world_region_id: WorldRegion.where(name: world_region).id, publisher: publisher, resource_type_id: new_resource_type.id, is_problem: is_problem)
      # "cognitive_bias_id"
      # "content"
      # "academic_citation"
      new_resource.save

      ResourcesBuildingBlockSubstep.create(building_block_substep_id: BuildingBlockSubstep.where(name: building_block_substep, building_block_id: BuildingBlock.where(name: building_block).id).id, resource_id: new_resource.id)

      ResourcesEnvironmentalSubtag.create(resource_id: new_resource.id, subtag_id: EnvironmentalSubtag.where(name: environmental_subtag, tag_id: EnvironmentalTag.where(name: environmental_tag).id).id)
    end


    # For the video audio tab. BE SURE TO DELETE THE FIRST COLUMN (IT'S A WEIRD THING WITH OLD HEADERS)
    csv3 = CSV.foreach('/Users/Andrew_Wei/Downloads/master_grabber_video_audio.csv', :headers => true) do |row|

      if row[0] == "Problem"
        is_problem = true
      else
        is_problem = false
      end
      building_block = row[1]
      environmental_tag = row[2]
      title = row[3]
      author = row[4]
      publisher = row[5]
      date = row[6]
      source = row[7]
      length = row[8]
      admin_notes = row[9]
      url = row[10]
      resource_type = "Video / Audio"
      building_block_substep = " "
      environmental_subtag = " "
      is_published = true


    # Skipped atm: cognitive bia

      if !BuildingBlock.where(name: building_block)
        BuildingBlock.create(name: building_block)
      end

      if !BuildingBlockSubstep.where(name: building_block_substep, building_block_id: BuildingBlock.where(name: building_block).id)
        BuildingBlockSubstep.create(name: building_block_substep, building_block_id: BuildingBlock.where(name: building_block).id)
      end

      if !EnvironmentalTag.where(name: environmental_tag)
        EnvironmentalTag.create(name: environmental_tag)
      end

      if !EnvironmentalSubtag.where(name: environmental_subtag, tag_id: EnvironmentalTag.where(name: environmental_tag).id)
        EnvironmentalSubTag.create(name: environmental_subtag, tag_id: EnvironmentalTag.where(name: environmental_tag).id)
      end

      if !ResourceType.where(name: resource_type)
        new_resource_type = ResourceType.new(name: resource_type)
        new_resource_type.save
      end

      new_resource = Resource.new(is_published: is_published, title: title, author: author, date: date, url: url, admin_notes: admin_notes, world_region_id: WorldRegion.where(name: world_region).id, publisher: publisher, resource_type_id: new_resource_type.id, source: source, length: length, is_problem: is_problem)
      # "cognitive_bias_id"
      # "content"
      # "academic_citation"
      new_resource.save

      ResourcesBuildingBlockSubstep.create(building_block_substep_id: BuildingBlockSubstep.where(name: building_block_substep, building_block_id: BuildingBlock.where(name: building_block).id).id, resource_id: new_resource.id)

      ResourcesEnvironmentalSubtag.create(resource_id: new_resource.id, subtag_id: EnvironmentalSubtag.where(name: environmental_subtag, tag_id: EnvironmentalTag.where(name: environmental_tag).id).id)
    end
end