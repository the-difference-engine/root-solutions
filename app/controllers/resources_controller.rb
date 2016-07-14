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
    if Resource.update(world_region: @resource.world_region, title: @resource.title,
      author: @resource.author, news_source: @resource.news_source, date: @resource.date, summary: @resource.summary
      url: @resource.url, notes: @resource.notes}
    end )
    redirect_to @resource
  else
    render :edit, notice: "Error"
  end
end

private

def resources_params
  params.require(:resource).permit(:world_region, :title, :author,
  :news_source, :date, :summary, :url, :notes)
end
end
