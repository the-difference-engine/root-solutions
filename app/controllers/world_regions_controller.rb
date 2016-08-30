class WorldRegionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_world_region, only: [:show, :edit, :update, :destroy]

  # GET /world_regions
  # GET /world_regions.json
  def index
    @world_regions = WorldRegion.all
  end

  # GET /world_regions/1
  # GET /world_regions/1.json
  def show
  end

  # GET /world_regions/new
  def new
    @world_region = WorldRegion.new
  end

  # GET /world_regions/1/edit
  def edit
  end

  # POST /world_regions
  # POST /world_regions.json
  def create
    @world_region = WorldRegion.new(world_region_params)

    respond_to do |format|
      if @world_region.save
        format.html { redirect_to @world_region, notice: 'World region was successfully created.' }
        format.json { render :show, status: :created, location: @world_region }
      else
        format.html { render :new }
        format.json { render json: @world_region.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /world_regions/1
  # PATCH/PUT /world_regions/1.json
  def update
    respond_to do |format|
      if @world_region.update(world_region_params)
        format.html { redirect_to @world_region, notice: 'World region was successfully updated.' }
        format.json { render :show, status: :ok, location: @world_region }
      else
        format.html { render :edit }
        format.json { render json: @world_region.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /world_regions/1
  # DELETE /world_regions/1.json
  def destroy
    @world_region.destroy
    respond_to do |format|
      format.html { redirect_to world_regions_path, notice: 'World region was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    WorldRegion.import(params[:file])
    redirect_to world_regions_path, notice: 'World Regions imported.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_world_region
      @world_region = WorldRegion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def world_region_params
      params.require(:world_region).permit(:name)
    end
end
