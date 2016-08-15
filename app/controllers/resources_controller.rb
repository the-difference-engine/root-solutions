require 'csv'
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

  def export_resources
    @resources = Resource.all
    csv_string = CSV.generate do |csv|
      csv << ["id", "world_region", "title", "author", "news_source", "date", "summary", "url", "notes"]
      @resources.each do |resource|
        csv << [resource.id, resource.world_region, resource.title, resource.author, resource.news_source, resource.date, resource.summary, resource.url, resource.notes]
      end
    end
    send_data csv_string,
    :type => 'text/csv; charset=iso-8859-1; header=present',
    :disposition => "attachment; filename=users.csv"
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
