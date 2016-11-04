require 'csv'
class ResourcesController < ApplicationController

  def index
    @resources = Resource.all
  end

  def new
    @resource = Resource.new
  end

  def show
    @resource = Resource.find_by(id: params[:id])
  end

  def create
    @resource = Resource.new(resources_params)
    @resource.save
    redirect_to @resource
  end

  def edit
    @resource = Resource.find_by(id: params[:id])
  end

  def update
    @resource = Resource.find_by(id: params[:id])
    @resource.update_attributes(resources_params)
    if @resource.valid?
      redirect_to resource_path(@resource)
    else
      render :edit, :status => :unprocessable_entity
    end
  end


  def export_resources
    @resources = Resource.all
    csv_string = CSV.generate do |csv|
      csv << ["id", "world_region", "title", "author", "news_source", "date", "summary", "url", "notes"]
      @resources.each do |resource|
        csv << [resource.id, resource.world_region, resource.title, resource.author, resource.news_source, resource.date, resource.summary, resource.url, resource.notes]
      end
    end
    send_data csv_string,
    :type => 'text/csv; charset=iso-8859-1; header=present',
    :disposition => "attachment; filename=users.csv"
  end

  def import_resources
    spreadsheet = Roo::Spreadsheet.open(params[:file])
    popular_articles = spreadsheet.sheet(1)
    resource_type = ResourceType.find_or_create_by(name: 'Popular Article')
    building_or_cogs = popular_articles.column(3)
    building_or_cogs.slice!(0)
    building_blocks = []
    cognitive_bia = []
    building_or_cogs.each do |boc|
      if boc
        if boc.include?("Cognitive Bias")
          boc.slice!("Cognitive Bias - ")
          if boc.include?(",")
            boc.split(',').each do |cog|
              cognitive_bia << cog.strip
            end
          else
            cognitive_bia << boc
          end
        else
          if boc.include?(',')
            boc.split(',').each do |cog|
              building_blocks << cog.strip
            end
          else
            building_blocks << boc
          end
        end
      end
    end
    # header = {is_published: 1, is_problem: 2, building_block_cognitive_bium: 3, building_block_substep: 4, environmental_tag: 5,  environmental_subtag: 6, world_region: 7, title: 8, author: 9, news_source: 10, date: 11, abstract: 12, url: 13, admin_notes: 14}
    building_blocks.each do |building_block|
      b_block = BuildingBlock.find_or_create_by(name: building_block)
      BuildingBlockSubstep.find_or_create_by(name: '', building_block_id: b_block.id)
    end
    cognitive_bia.each do |cognitive_bium|
      CognitiveBium.find_or_create_by(name: cognitive_bium)
    end
    popular_articles.column(5).each do |environmental_tag|
      if environmental_tag
        if environmental_tag.include?(',')
          arr = environmental_tag.split(', ')
          arr.each do |environmental_tag2|
            e_tag = EnvironmentalTag.find_or_create_by(name: environmental_tag2)
            EnvironmentalSubtag.find_or_create_by(name: '', environmental_tag_id: e_tag.id)
          end
        else
          e_tag = EnvironmentalTag.find_or_create_by(name: environmental_tag)
          EnvironmentalSubtag.find_or_create_by(name: '', environmental_tag_id: e_tag.id)
        end
      end
    end
    popular_articles.column(10).each do |news_source|
      NewsSource.find_or_create_by(name: news_source)
    end
    popular_articles.column(7).each do |world_region|
      WorldRegion.find_or_create_by(name: world_region)
    end
    (popular_articles.last_row - 1).times do |i|
      resource = Resource.new(
        title: popular_articles.cell((i + 2), 8),
        author: popular_articles.cell((i + 2), 9),
        date: popular_articles.cell((i + 2), 11),
        abstract: popular_articles.cell((i + 2), 12),
        url: popular_articles.cell((i + 2), 13),
        admin_notes: popular_articles.cell((i + 2), 14)
      )
      if NewsSource.find_by(name: popular_articles.cell((i + 2), 10))
        resource.assign_attributes(news_source_id: NewsSource.find_by(name: popular_articles.cell((i + 2), 10)).id)
      end
      if popular_articles.cell((i + 2), 1) == 'Published'
        resource.assign_attributes(is_published: true)
      else
        resource.assign_attributes(is_published: false)
      end
      if popular_articles.cell((i + 2), 2) == 'Problem'
        resource.assign_attributes(is_problem: true)
      else
        resource.assign_attributes(is_problem: false)
      end
      resource.save
      if popular_articles.cell((i + 2), 3)
        if popular_articles.cell((i + 2), 3).include?(',')
          arr = popular_articles.cell((i + 2), 3).split(', ')
          arr.each do |boc|
            if boc.include?('Cognitive Bias')
              boc.slice!('Cognitive Bias - ')
              ResourcesCognitiveBium.create(
                cognitive_bium_id: CognitiveBium.find_by(name: boc).id,
                resource_id: resource.id
                )
            else
              ResourcesBuildingBlockSubstep.create(
                building_block_substep_id: BuildingBlockSubstep.find_by(building_block_id: BuildingBlock.find_by(name: boc).id).id,
                resource_id: resource.id
                )
            end
          end
        elsif popular_articles.cell((i + 2), 3).include?('Cognitive Bias')
          cog = popular_articles.cell((i + 2), 3).dup
          cog.slice!('Cognitive Bias - ')
          ResourcesCognitiveBium.create(
            cognitive_bium_id: CognitiveBium.find_by(name: cog).id,
            resource_id: resource.id
            )
        else
          ResourcesBuildingBlockSubstep.create(
            building_block_substep_id: BuildingBlockSubstep.find_by(building_block_id: BuildingBlock.find_by(name: popular_articles.cell((i + 2), 3)).id).id,
            resource_id: resource.id
            )
        end
      end
      if popular_articles.cell((i + 2), 5)
        if popular_articles.cell((i + 2), 5).include?(',')
          arr = popular_articles.cell((i + 2), 5).split(', ')
          arr.each do |environmental_tag|
            ResourcesEnvironmentalSubtag.create(
              subtag_id: EnvironmentalSubtag.find_by(environmental_tag_id: EnvironmentalTag.find_by(name: environmental_tag).id).id,
              resource_id: resource.id
              )
          end
        else
          ResourcesEnvironmentalSubtag.create(
            subtag_id: EnvironmentalSubtag.find_by(environmental_tag_id: EnvironmentalTag.find_by(name: popular_articles.cell((i + 2), 5)).id).id
            )
        end
      end
      if popular_articles.cell((i + 2), 7)
        if popular_articles.cell((i + 2), 7).include?(',')
          arr = popular_articles.cell((i + 2), 7).split(', ')
          arr.each do |world_region|
            ResourcesWorldRegion.create(
              world_region_id: WorldRegion.find_by(name: world_region).id,
              resource_id: resource.id
              )
          end
        else
          ResourcesWorldRegion.create(
            world_region_id: WorldRegion.find_by(name: popular_articles.cell((i + 2), 7)).id,
            resource_id: resource.id
            )
        end
      end
    end
    redirect_to "/resources"
  end

  def destroy
    @resource = Resource.find_by(id: params[:id])
    @resource.destroy
    redirect_to resources_path
  end

private
  def resources_params
    params.require(:resource).permit(:title, :author, :date, :abstract, :url,
    :admin_notes, :world_region_id, :news_source_id, :resource_type_id, :is_published,
    :is_problem, :cognitive_bium_id, :content, :academic_citation, :publisher, :source, :length)
  end
end
