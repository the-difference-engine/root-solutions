class SearchesController < ApplicationController

  def index
    @resources = Resource.all
  end

end
