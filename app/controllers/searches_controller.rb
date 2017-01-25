class SearchesController < ApplicationController
  layout "pages"

  def index
    @resources = Resource.all
  end

  def search
    @resources = Resource.all

    if (params[:resource_type] != nil)
      @resources = resource_type(@resources, params[:resource_type])
    end

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
  # def building_block(resources, )

  def resource_type(resources, name)
    resource_type = ResourceType.find_by(name: name)
    return resources = resources.where("resource_type_id = #{resource_type.id}")
  end

  def hash_create(resources)
    resources_hash = []
    resources.each do |resource|
      building_blocks = []
      resource.building_blocks.each do |building_block|
        building_blocks << building_block.name
      end
      building_block_substeps = []
      resource.building_block_substeps.each do |building_block_substeps|
        building_block_substeps << building_block_substeps.name
      end
      cognitive_bia = []
      resource.cognitive_bia.each do |cognitive_bium|
        cognitive_bia << cognitive_bium.name
      end
      environmental_tags = []
      resource.environmental_tags.each do |environmental_tag|
        environmental_tags << environmental_tag.name
      end
      environmental_subtags = []
      resource.environmental_subtags.each do |environmental_subtag|
        environmental_subtags << environmental_subtag.name
      end
      world_regions = []
      resource.world_regions.each do |world_region|
        world_regions << world_region.name
      end
      news_source_name = NewsSource.find_by(id: resource.news_source_id).name
      new_hash = {
        abstract: resource.abstract,
        author: resource.author,
        date: resource.date,
        description: resource.description,
        id: resource.id,
        is_problem: resource.is_problem,
        is_published: resource.is_published,
        is_solution: resource.is_solution,
        news_source: news_source_name,
        publisher: resource.publisher,
        source: resource.source,
        title: resource.title,
        url: resource.url,
        building_blocks: building_blocks,
        building_block_substeps: building_block_substeps,
        cognitive_bia: cognitive_bia,
        environmental_tags: environmental_tags,
        environmental_subtags: environmental_subtags,
        world_region: world_regions
      }
      resources_hash << new_hash
    end
    return resources_hash
  end
end
