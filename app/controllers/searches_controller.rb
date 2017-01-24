class SearchesController < ApplicationController

  def index
    @resources = Resource.all
  end

  def search
    @resources = Resource.all

    if (params[:filters]["0"][0] == "resource_type")
      resource_type = ResourceType.find_by(name: params[:filters]["0"][1])
      @resources = @resources.select("resources.*, world_regions.name").joins(:world_regions).where("resource_type_id = #{resource_type.id}").to_a
      resources_add = Resource.where("resource_type_id = #{resource_type.id}").to_a
      if (!@resources.empty?)
        @resources = hash_create(@resources)
      end
      if (!resources_add.empty?)
        resources_add = hash_create_no_wr(resources_add)
      end
      @resources = @resources.concat(resources_add)
      if (@resources.uniq != nil)
        @resources.uniq!
      end
    end

    puts "------------------------------------------------------------------------------"
    puts "DONE WITH GRAB, SENDING INFO"
    puts "------------------------------------------------------------------------------"

    respond_to do |format|
      format.json {render json: {resources: @resources}}
    end
  end

  private

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
        is_problem: resource.is_problem,
        is_published: resource.is_published,
        is_solution: resource.is_solution,
        news_source: news_source_name,
        publisher: resource.publisher,
        source: resource.source,
        title: resource.title,
        url: resource.url,
        world_region: resource.name
      }
      resources_hash << new_hash
    end
    return resources_hash
  end

  def hash_create_no_wr(resources)
    resources_hash = []
    resources.each do |resource|
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
        world_region: nil
      }
      resources_hash << new_hash
    end
    return resources_hash
  end

end


# SELECT resources.*, world_regions.name, resource_types.*
# FROM "resources" 
# INNER JOIN "resources_world_regions" ON "resources_world_regions"."resource_id" = "resources"."id" 
# INNER JOIN "world_regions" ON "world_regions"."id" = "resources_world_regions"."world_region_id" 
# INNER JOIN "resource_types" ON "resource_types"."id" = "resources"."resource_type_id" 
# WHERE resource_types.name IN('Academic Article')