class SearchesController < ApplicationController
  layout "pages"

  def index
    @resources = Resource.all
  end

  def show
    @resource = Resource.find_by(id: params[:id])
  end

  def search
    @resources = []

    if (params[:filters]["0"][0] == "resource_type")
      resource_type = ResourceType.find_by(name: params[:filters]["0"][1])
      @resources = Resource.select("resources.*, world_regions.name").left_outer_joins(:world_regions).where("resource_type_id = #{resource_type.id}")
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
end
