require 'csv'

namespace :importer_data do
  desc "Populate resource table from popular_articles_for_web file"
  task popular_articles_for_web: :environment do
    csv_text = File.read(Rails.root.join('lib', 'seeds', 'popular_articles_for_web.csv'))
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      resource = Resource.new
      resource.title = row['Title']
      resource.author = row['Author']
      if row['Date'].include?('/')
        resource.date = DateTime.strptime(row['Date'],'%m/%d/%y')
      else
        resource.date = DateTime.strptime(row['Date'],'%Y')
      end
      resource.url = row['URL']
      resource.is_published = true

      if row['News Source']
        NewsSource.create!(name:row['News Source']) if NewsSource.find_by(name:row['News Source']).nil?
        resource.news_source_id = NewsSource.find_by(name:row['News Source']).id
      end

      ResourceType.create!(name:'Popular Article') if ResourceType.find_by(name:'Popular Article').nil?
      resource.resource_type_id = ResourceType.find_by(name:'Popular Article').id

      if row['Problem or Solution?']
        resource.is_problem = row['Problem or Solution?'].include?("Problem")
      else
        resource.is_problem = false
      end

      if row['BUILDING BLOCK or COGNITIVE BIAS'].include?('Cognitive Bias')

        if row['BUILDING BLOCK or COGNITIVE BIAS'] == ""
          CognitiveBium.create!(name:'Neither') if CognitiveBium.find_by(name:'Neither').nil?
          resource.cognitive_bium_id = CognitiveBium.find_by(name:'Neither').id
        else
          dash_position = row['BUILDING BLOCK or COGNITIVE BIAS'].index('-')
          start =  dash_position + 2
          cutted = row['BUILDING BLOCK or COGNITIVE BIAS'][start+2..-1]
          CognitiveBium.create!(name:cutted) if CognitiveBium.find_by(name:cutted).nil?
          resource.cognitive_bium_id = CognitiveBium.find_by(name:row['BUILDING BLOCK or COGNITIVE BIAS']).id
        end

      else
        building_block_list = row['BUILDING BLOCK or COGNITIVE BIAS'].split(',')
          building_block_list.each do |building_block_item|
            if BuildingBlock.find_by(name:building_block_item).nil?
              building_block = BuildingBlock.create!(name:building_block_item)
            else
              building_block = BuildingBlock.find_by(name:building_block_item)
            end
            # Todo add this in the Joined Resource_Building_Block
          end
      end



      if row['World Region'].include?(',')
        row['World Region'].split(', ').each do |region|
          world_region = WorldRegion.find_by(name:region)
          if world_region
            resource.world_region_id = world_region.id
          else
            WorldRegion.create!(name:region)
            resource.world_region_id = WorldRegion.find_by(name:region).id
          end
        end
      else
        world_region = WorldRegion.find_by(name:row['World Region'])
        if world_region
          resource.world_region_id = world_region.id
        else
          WorldRegion.create!(name:row['World Region'])
          resource.world_region_id = WorldRegion.find_by(name:row['World Region']).id
        end
      end

      if name:row['Environmental Tag'].include?(',')
        tag_list = name:row['Environmental Tag'].split(',')
        tag_list.each do |tag|
          dash_position = tag.index('-')
          crop_tag = tag[0..dash_position-1]

          environmental_tag = EnvironmentalTag.find_by(name:crop_tag)
          if environmental_tag
            resource.environmental_tag_id = environmental_tag.id
          else
            EnvironmentalTag.create!(name:crop_tag)
            resource.environmental_tag_id = EnvironmentalTag.find_by(name:crop_tag).id
          end

          crop_sub_tag = tag[dash_position+2..-1]
          environmental_subtag = EnvironmentalSubtag.find_by(name:crop_sub_tag)
          if environmental_subtag
            ResourceEnvironmentalSubtag.create!(resource_id: resource.id,subtag_id:environmental_subtag)
          else
            environmental_subtag = EnvironmentalSubtag.create!(name:crop_sub_tag)
            ResourceEnvironmentalSubtag.create!(resource_id: resource.id,subtag_id:environmental_subtag)
          end

        end

      else

        tag = row['Environmental Tag']
        dash_position = tag.index('-')
        crop_tag = tag[0..dash_position-1]

        environmental_tag = EnvironmentalTag.find_by(name:crop_tag)
        if environmental_tag
          resource.environmental_tag_id = environmental_tag.id
        else
          EnvironmentalTag.create!(name:crop_tag)
          resource.environmental_tag_id = EnvironmentalTag.find_by(name:crop_tag).id
        end

        crop_sub_tag = tag[dash_position+1..-1]
        environmental_subtag = EnvironmentalSubtag.find_by(name:crop_sub_tag)
        if environmental_subtag
          ResourceEnvironmentalSubtag.create!(resource_id: resource.id,subtag_id:environmental_subtag)
        else
          environmental_subtag = EnvironmentalSubtag.create!(name:crop_sub_tag)
          ResourceEnvironmentalSubtag.create!(resource_id: resource.id,subtag_id:environmental_subtag)
        end

      end

      resource.save!
    end
  end

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
      resource.save
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
