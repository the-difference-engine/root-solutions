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
      csv << ["id", "is_published", "is_problem", "world_region_id", "title", "author", "publisher", "abstract", "news_source_id", "date", "summary", "url", "source", "length", "notes", "resource type id", "cognitive bias id", "content", "academic citation"]
      @resources.each do |resource|
        csv << [resource.id, resource.is_published, resource.is_problem, resource.world_region_id, resource.title, resource.author, resource.publisher, resource.abstract, resource.news_source_id, resource.date, resource.summary, resource.url, resource.source, resource.length, resource.admin_notes, resource.resource_type_id, resource.cognitive_bias_id, resource.content, resource.academic_citation]
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
