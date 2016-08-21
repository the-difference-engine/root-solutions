class BuildingBlocksController < ApplicationController
  before_action :set_building_block, only: [:show, :edit, :update, :destroy]

  # GET /building_block
  # GET /building_block.json
  def index
    @building_blocks = BuildingBlock.all
  end

  # GET /building_block/1
  # GET /building_block/1.json
  def show
  end

  # GET /building_block/new
  def new
    @building_block = BuildingBlock.new
  end

  # GET /building_block/1/edit
  def edit
  end

  # POST /building_block
  # POST /building_block.json
  def create
    @building_block = BuildingBlock.new(building_block_params)

    respond_to do |format|
      if @building_block.save
        format.html { redirect_to @building_block, notice: 'Building block was successfully created.' }
        format.json { render :show, status: :created, location: @building_block }
      else
        format.html { render :new }
        format.json { render json: @building_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /building_block/1
  # PATCH/PUT /building_block/1.json
  def update
    respond_to do |format|
      if @building_block.update(building_block_params)
        format.html { redirect_to @building_block, notice: 'Building block was successfully updated.' }
        format.json { render :show, status: :ok, location: @building_block }
      else
        format.html { render :edit }
        format.json { render json: @building_block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /building_block/1
  # DELETE /building_block/1.json
  def destroy
    @building_block.destroy
    respond_to do |format|
      format.html { redirect_to building_blocks_path, notice: 'Building block was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_building_block
      @building_block = BuildingBlock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def building_block_params
      params.require(:building_block).permit(:name, :building_block_id)
    end
end
