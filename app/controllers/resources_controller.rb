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
    header = [:is_published, :is_problem, :building_block_cognitive_bium, :environmental_subtag, :environmental_tag, :environmental_subtag, :world_region, :title, :author, :news_source, :date, :abstract, :url, :admin_notes]
    resource_type = ResourceType.create(name: 'Popular Article')
    building_or_cogs = popular_articles.column(3)
    building_or_cogs.slice!(0)
    building_blocks = []
    cognitive_bia = []
    building_or_cogs.each do |boc|
      if boc.include?("Cognitive Bias")
        boc.slice!("Cognitive Bias - ")
        if boc.include?(",")
          boc.split(',').each do |cog|
            cognitive_bia << cog.strip
          end
        else
          cognitive_bia << cog
        end
      else
        if boc.include?(',')
          boc.split(',').each do |cog|
            building_blocks << boc.strip
          end
        else
          building_blocks << boc
        end
      end
    end
    building_blocks.each do |building_block|
      BuildingBlock.create(name: building_block)
    end
    cognitive_bia.each do |cognitive_bium|
      CognitiveBium.create(name: cognitive_bium)
    end
    popular_articles.column(5).each do |environmental_tag|
      EnvironmentalTag.create(name: environmental_tag)
    end
    popular_articles.column(4).each do |environmental_subtag|
      i
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
