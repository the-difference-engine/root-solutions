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
      ResourceType.create!(name:'N/A') if ResourceType.find_by(name:'N/A').nil?
      resource.resource_type_id = ResourceType.find_by(name:'N/A').id
      CognitiveBium.create!(name:'N/A') if CognitiveBium.find_by(name:'N/A').nil?
      resource.cognitive_bium_id = CognitiveBium.find_by(name:'N/A').id
      resource.save!
    end
  end

  desc "Populate resource table from video file"
  task import_video: :environment do
  end

  desc "Populate resource table from popular file"
  task import_popular: :environment do
  end

end
