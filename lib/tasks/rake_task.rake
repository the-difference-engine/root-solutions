require 'csv'

csv = CSV.parse('/Users/Andrew_Wei/Downloads/master_grabber.csv', :headers => true) do |row|
  columns = row.split(",")
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

# Skipped atm: cognitive bia, resource types

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

  new_resource = Resource.new(title: title, author: author, date: date, abstract: summary, url: url, admin_notes: admin_notes, world_region_id: WorldRegion.where(name: world_region).id, news_source_id: NewsSource.where(name: news_source).id, is_problem: is_problem)
  # "resource_type_id"
  # "is_published",      default: false
  # "cognitive_bias_id"
  # "content"
  # "academic_citation"
  new_resource.save

  ResourcesBuildingBlockSubstep.create(building_block_substep_id: BuildingBlockSubstep.where(name: building_block_substep, building_block_id: BuildingBlock.where(name: building_block).id).id, resource_id: new_resource.id)

  ResourcesEnvironmentalSubtag.create(resource_id: new_resource.id, subtag_id: EnvironmentalSubtag.where(name: environmental_subtag, tag_id: EnvironmentalTag.where(name: environmental_tag).id).id)
end