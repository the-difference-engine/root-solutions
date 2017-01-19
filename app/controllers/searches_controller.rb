class SearchesController < ApplicationController

  def index
    @resources = Resource.all
  end

  def search
    @resources = Resource.all

    if (params[:filters]["0"][0] == "resource_type")
      @resources = @resources.select("resources.*, world_regions.name").joins(:world_regions).includes(:resource_type).where(resource_types: {name: params[:filters]["0"][1]})
      binding.pry
      @resources = @resources.includes(:resource_type).where(resource_types: {name: params[:filters]["0"][1]})
      @resources = hash_create(@resources)
    end

    respond_to do |format|
      format.json {render json: {resources: @resources}}
    end
  end

  private

  def hash_create(resources)
    resources_hash = []
    @resources.each do |resource|
      new_hash = {
        abstract: null,
        author: "Autumn Rauchwerk",
        created_at: "2017-01-05T04:26:21.604Z",
        date: resource.date,
        description: resource.description,
        id: resource.id,
        is_problem: resource.is_problem,
        is_published: resource.is_published,
        is_solution: resource.is_solution,
        publisher: resource.publisher,
        source: resource.source,
        title: resource.title,
        url: resource.url,
        world_region: resource.name
      }
    end
  end

end


SELECT resources.*, world_regions.name, resource_types.*
FROM "resources" 
INNER JOIN "resources_world_regions" ON "resources_world_regions"."resource_id" = "resources"."id" 
INNER JOIN "world_regions" ON "world_regions"."id" = "resources_world_regions"."world_region_id" 
INNER JOIN "resource_types" ON "resource_types"."id" = "resources"."resource_type_id" 
WHERE resource_types.name IN('Academic Article')