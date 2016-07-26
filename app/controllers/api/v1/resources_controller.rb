class Api::V1::ResourcesController < ApplicationController

  def index
    @resources = Resource.all
  end
  
end
