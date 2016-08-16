class BuildingBlockSubstepsController < ApplicationController
  before_action :set_building_block_substep, only: [:show, :edit, :update, :destroy]

  # GET /building_block_substeps
  # GET /building_block_substeps.json
  def index
    @building_block_substeps = BuildingBlockSubstep.all
  end

  # GET /building_block_substeps/1
  # GET /building_block_substeps/1.json
  def show
  end

  # GET /building_block_substeps/new
  def new
    @building_block_substep = BuildingBlockSubstep.new
  end

  # GET /building_block_substeps/1/edit
  def edit
  end

  # POST /building_block_substeps
  # POST /building_block_substeps.json
  def create
    @building_block_substep = BuildingBlockSubstep.new(building_block_substep_params)

    respond_to do |format|
      if @building_block_substep.save
        format.html { redirect_to @building_block_substep, notice: 'Building block substep was successfully created.' }
        format.json { render :show, status: :created, location: @building_block_substep }
      else
        format.html { render :new }
        format.json { render json: @building_block_substep.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /building_block_substeps/1
  # PATCH/PUT /building_block_substeps/1.json
  def update
    respond_to do |format|
      if @building_block_substep.update(building_block_substep_params)
        format.html { redirect_to @building_block_substep, notice: 'Building block substep was successfully updated.' }
        format.json { render :show, status: :ok, location: @building_block_substep }
      else
        format.html { render :edit }
        format.json { render json: @building_block_substep.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /building_block_substeps/1
  # DELETE /building_block_substeps/1.json
  def destroy
    @building_block_substep.destroy
    respond_to do |format|
      format.html { redirect_to building_block_substeps_url, notice: 'Building block substep was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_building_block_substep
      @building_block_substep = BuildingBlockSubstep.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def building_block_substep_params
      params.require(:building_block_substep).permit(:name, :building_block_id)
    end
end
