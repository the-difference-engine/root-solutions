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

  private

  def resources_params
    params.require(:resource).permit(:world_region, :title, :author,
    :news_source, :date, :summary, :url, :notes)
  end
end
