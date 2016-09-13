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

end
