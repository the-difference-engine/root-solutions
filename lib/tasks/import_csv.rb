require 'csv'
namespace :custom_rake_task do
  task :import_csv do
    # For the popular article tab
    csv = CSV.parse('/Users/Andrew_Wei/Downloads/master_grabber_popular_article.csv', :headers => true) do |row|
      columns = row.split(",")
      if columns[0] == "Yes"
        is_published = true
      else
        is_published = false
      end
      if columns[1] == "Problem"
        is_problem = true
      else
        is_problem = false
      end
      building_block = columns[2]
      building_block_substep = columns[3]
      environmental_tag = columns[4]
      environmental_subtag = columns[5]
      world_region = columns[6]
      title = columns[7]
      author = columns[8]
      news_source = columns[9]
      date = columns[10]
      summary = columns[11]
      url = columns[12]
      admin_notes = columns[13]
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
    csv2 = CSV.parse('/Users/Andrew_Wei/Downloads/master_grabber_academic_article.csv', :headers => true) do |row|
      columns = row.split(",")
      if columns[0] == "Yes"
        is_published = true
      else
        is_published = false
      end
      if columns[1] == "Problem"
        is_problem = true
      else
        is_problem = false
      end
      building_block = columns[2]
      building_block_substep = columns[3]
      environmental_tag = columns[4]
      environmental_subtag = columns[5]
      world_region = columns[6]
      title = columns[7]
      author = columns[8]
      publisher = columns[9]
      date = columns[10]
      abstract = columns[11]
      url = columns[12]
      admin_notes = columns[13]
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
    csv3 = CSV.parse('/Users/Andrew_Wei/Downloads/master_grabber_video_audio.csv', :headers => true) do |row|
      columns = row.split(",")
      if columns[0] == "Problem"
        is_problem = true
      else
        is_problem = false
      end
      building_block = columns[1]
      environmental_tag = columns[2]
      title = columns[3]
      author = columns[4]
      publisher = columns[5]
      date = columns[6]
      source = columns[7]
      length = columns[8]
      admin_notes = columns[9]
      url = columns[10]
      resource_type = "Video / Audio"
      building_block_substep = " "
      environmental_subtag = " "


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

      new_resource = Resource.new(title: title, author: author, date: date, url: url, admin_notes: admin_notes, world_region_id: WorldRegion.where(name: world_region).id, publisher: publisher, resource_type_id: new_resource_type.id, source: source, length: length, is_problem: is_problem)
      # "cognitive_bias_id"
      # "content"
      # "academic_citation"
      new_resource.save

      ResourcesBuildingBlockSubstep.create(building_block_substep_id: BuildingBlockSubstep.where(name: building_block_substep, building_block_id: BuildingBlock.where(name: building_block).id).id, resource_id: new_resource.id)

      ResourcesEnvironmentalSubtag.create(resource_id: new_resource.id, subtag_id: EnvironmentalSubtag.where(name: environmental_subtag, tag_id: EnvironmentalTag.where(name: environmental_tag).id).id)
    end
  end
end