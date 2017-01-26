class SearchesController < ApplicationController
  layout "pages"

  def index
    @resources = Resource.all
  end

  def show
    @resource = Resource.find_by(id: params[:id])
  end

  def search
    @resources = Resource.all

    # resource_type query
    if (params[:resource_type] != nil)
      @resources = query_resource_type(@resources, params[:resource_type])
    end

    # world_region query
    if (params[:world_region])
      @resources = query_world_region(@resources, params[:world_region])
    end

    # building_block query
    if (params[:building_block])
      @resources = query_building_block(@resources, params[:building_block])
    end

    # environmental_tag query
    if (params[:environmental_tag])
      @resources = query_environmental_tag(@resources, params[:environmental_tag])
    end

    # cognitive_bium query
    if (params[:cognitive_bium])
      @resources = query_cognitive_bium(@resources, params[:cognitive_bium])
    end

    # building_block_substep query
    if (params[:building_block_substep])
      @resources = query_building_block_substep(@resources, params[:building_block_substep])
    end

    # environmental_subtag query
    if (params[:environmental_subtag])
      @resources = query_environmental_subtag(@resources, params[:environmental_subtag])
    end

    # final step: create hash out of query results
    if (!@resources.empty?)
      @resources = hash_create(@resources)
    end

    puts "------------------------------------------------------------------------------"
    puts "DONE WITH GRAB, SENDING INFO"
    puts "------------------------------------------------------------------------------"

    respond_to do |format|
      format.json {render json: {resources: @resources}}
    end
  end

  private
  def query_building_block(resources, building_blocks)
    return resources.joins(:building_blocks).where(building_blocks: {name: building_blocks})
  end

  def query_building_block_substep(resources, building_block_substeps)
    return resources.joins(:building_block_substeps).where(building_block_substeps: {name: building_block_substeps})
  end

  def query_cognitive_bium(resources, cognitive_bia)
    return resources.joins(:cognitive_bia).where(cognitive_bia: {name: cognitive_bia})
  end

  def query_environmental_tag(resources, environmental_tags)
    return resources.joins(:environmental_tags).where(environmental_tags: {name: environmental_tags})
  end

  def query_environmental_subtag(resources, environmental_subtags)
    return resources.joins(:environmental_subtags).where(environmental_subtags: {name: environmental_subtags})
  end

  def query_resource_type(resources, name)
    resource_type = ResourceType.find_by(name: name)
    return resources = resources.where("resource_type_id = #{resource_type.id}")
  end

  def query_world_region(resources, world_regions)
    return resources.joins(:world_regions).where(world_regions: {name: world_regions})
  end

  def hash_create(resources)
    resources_hash = []
    resources.each do |resource|
      news_source_name = NewsSource.find_by(id: resource.news_source_id).name
      new_hash = {
        abstract: resource.abstract,
        author: resource.author,
        date: resource.date,
        description: resource.description,
        id: resource.id,
        title: resource.title,
        url: resource.url,
      }
      resources_hash << new_hash
    end
    return resources_hash
  end
end
