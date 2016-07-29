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
  def destroy
    @resource = Resource.find_by(id: params[:id])
    @resource.destroy
    redirect_to "/resources"
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

  def destroy
    @resource = Resource.find_by(id: params[:id])
    @resource.destroy
    redirect_to resources_path
  end

private
  def resources_params
    params.require(:resource).permit(:world_region, :title, :author,
    :news_source, :date, :summary, :url, :notes)
  end
end
