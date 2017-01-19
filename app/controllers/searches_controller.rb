class SearchesController < ApplicationController

  def index
    @resources = Resource.all
  end

  def search
    @resources = Resource.all

    if (params[:resource_type])
      @resources = @resources.includes(:resource_type).where(resource_types: {name: params[:resource_type]})
    end

    respond_to do |format|
      format.json {render json: {resources: @resources}}
    end
  end

end
