require 'csv'

namespace :importer_data do
  desc "Populate resource table from academic file"
  task import_academic: :environment do
    csv_text = File.read(Rails.root.join('lib', 'seeds', 'academic_articles.csv'))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      resource = Resource.new
      resource.title = row['Title']
      resource.author = row['Author']
      resource.date = DateTime.strptime(row['Date'],'%Y')
      resource.abstract = row['Abstract']
      resource.url = row['URL']
      resource.admin_notes = row['Notes']
      resource.publisher = row['Publisher']
      resource.is_published = row['Website?'].downcase == "yes" ? true : false
      resource.is_problem = row['Problem or Solution?'].include?("Problem")
      world_region = WorldRegion.find_by(name:row['World Region'])
      if world_region
        resource.world_region_id = world_region.id
      else
        WorldRegion.create!(name:row['World Region'])
        resource.world_region_id = WorldRegion.find_by(name:row['World Region']).id
      end
      NewsSource.create!(name:'N/A') if NewsSource.find_by(name:'N/A').nil?
      resource.news_source_id = NewsSource.find_by(name:'N/A').id
      ResourceType.create!(name:'Academic Article') if ResourceType.find_by(name:'Academic Article').nil?
      resource.resource_type_id = ResourceType.find_by(name:'Academic Article').id
      CognitiveBium.create!(name:'N/A') if CognitiveBium.find_by(name:'N/A').nil?
      resource.cognitive_bium_id = CognitiveBium.find_by(name:'N/A').id
      resource.save!
    end
  end

  desc "Populate resource table from video file"
  task import_video: :environment do
    # Website?,Problem or Solution?,BUILDING BLOCK,Substep,Environmental Tag,Environmental SubTag,World Region,Title,Author,Publisher,Date,Date,Abstract,URL,Notes
    csv_text = File.read(Rails.root.join('lib', 'seeds', 'video_audio.csv'))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      resource = Resource.new
      resource.title = row['Title']
      resource.author = row['Author']
      resource.date = DateTime.strptime(row['Date'],'%Y')
      resource.abstract = row['Abstract']
      resource.url = row['URL']
      resource.admin_notes = row['Notes']
      resource.publisher = row['Publisher']
      resource.is_published = row['Website?'].downcase == "yes" ? true : false
      resource.is_problem = row['Problem or Solution?'].include?("Problem")
      if resource.is_problem
        CognitiveBium.create!(name:row['BUILDING BLOCK']) if CognitiveBium.find_by(name:row['BUILDING BLOCK']).nil?
        resource.cognitive_bium_id = CognitiveBium.find_by(name:row['BUILDING BLOCK']).id
      elsif row['Problem or Solution?'].include?("Solution")
        BuildingBlock.create!(name:row['BUILDING BLOCK']) if BuildingBlock.find_by(name:row['BUILDING BLOCK']).nil?
        building_block_id = BuildingBlock.find_by(name:row['BUILDING BLOCK']).id
        building_block_substep = BuildingBlockSubstep.find_by(name:row['Substep'], building_block_id: building_block_id)
        if building_block_substep
          building_block_substep_id = BuildingBlockSubstep.find_by(name:row['Substep']).id
          # Insert the resource id and the building_block_substep_id in table resources_building_block_substeps
        else
          BuildingBlockSubstep.create!(name:row['Substep'], building_block_id: building_block_id)
          # Insert the resource id and the building_block_substep_id in table resources_building_block_substeps
          building_block_substep_id = BuildingBlockSubstep.find_by(name:row['Substep']).id
        end
      end
      world_region = WorldRegion.find_by(name:row['World Region'])
      if world_region
        resource.world_region_id = world_region.id
      else
        WorldRegion.create!(name:row['World Region'])
        resource.world_region_id = WorldRegion.find_by(name:row['World Region']).id
      end
      NewsSource.create!(name:'N/A') if NewsSource.find_by(name:'N/A').nil?
      resource.news_source_id = NewsSource.find_by(name:'N/A').id
      ResourceType.create!(name:'Video/Audio') if ResourceType.find_by(name:'Video/Audio').nil?
      resource.resource_type_id = ResourceType.find_by(name:'Video/Audio').id
      resource.save!
    end
  end

  desc "Populate resource table from popular file"
  task import_popular: :environment do
    # Website?,Behavioral Problem,BUILDING BLOCK,Substep,Environmental Tag,Environmental SubTag,World Region,Title,Author,News Source,Date,Summary,URL,Notes
    csv_text = File.read(Rails.root.join('lib', 'seeds', 'popular_articles.csv'))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      resource = Resource.new
      resource.title = row['Title']
      resource.author = row['Author']
      resource.date = DateTime.strptime(row['Date'],'%Y')
      resource.content = row['Summary']
      resource.url = row['URL']
      resource.admin_notes = row['Notes']
      resource.publisher = row['Publisher']
      resource.is_published = row['Website?'].downcase == "yes" ? true : false
      resource.is_problem = row['Problem or Solution?'].include?("Problem")
      world_region = WorldRegion.find_by(name:row['World Region'])
      if world_region
        resource.world_region_id = world_region.id
      else
        WorldRegion.create!(name:row['World Region'])
        resource.world_region_id = WorldRegion.find_by(name:row['World Region']).id
      end
      news_source = NewsSource.find_by(name:row['News Source'])
      if news_source
        resource.news_source_id = news_source.id
      else
        NewsSource.create!(name:row['News Source'])
        resource.news_source_id = NewsSource.find_by(name:row['News Source']).id
      end
      ResourceType.create!(name:'Popular Article') if ResourceType.find_by(name:'Popular Article').nil?
      resource.resource_type_id = ResourceType.find_by(name:'Popular Article').id
      CognitiveBium.create!(name:'N/A') if CognitiveBium.find_by(name:'N/A').nil?
      resource.cognitive_bium_id = CognitiveBium.find_by(name:'N/A').id
      resource.save!
    end
  end

end
