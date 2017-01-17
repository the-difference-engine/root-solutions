class SearchesController < ApplicationController

  def index
    search = params[:q]
    @resources = Resource.search "#{search}"
    @news_sources = NewsSource.all
    @world_regions = WorldRegion.all
    @resource_types = ResourceType.all
    @cognitive_bia = CognitiveBium.all
    @building_blocks = BuildingBlock.all
    @environmental_tags = EnvironmentalTag.all
    @building_block_substeps = BuildingBlockSubstep.all
    @environmental_subtags = EnvironmentalSubtag.all
    respond_to do |format|
     format.html
     format.json { render json: @resources }
    end
  end

  def search
    @resources = Resource.all

    if (params[:resource_type])
      @resources = @resources.includes(:resource_type).where(resource_types: {name: params[:resource_type]})
    end

    respond_to do |format|
      format.json {render json: {resources: @resources}}
    end
  end

end
