require 'csv'
class ResourcesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
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
    @resource.update_attributes(resources_params)
    if @resource.valid?
      redirect_to resource_path(@resource)
    else
      render :edit, :status => :unprocessable_entity
    end
  end

  def import_resources
    excel_import = ExcelImport.new(params[:file])
    excel_import.main
    redirect_to "/resources"
  end

  def destroy
    @resource = Resource.find_by(id: params[:id])
    @resource.destroy
    redirect_to resources_path
  end

private
  def resources_params
    params.require(:resource).permit(:title, :author, :date, :abstract, :url,
    :admin_notes, :world_region_id, :news_source_id, :resource_type_id, :is_published,
    :is_problem, :cognitive_bium_id, :content, :academic_citation, :publisher, :source, :length)
  end
end
