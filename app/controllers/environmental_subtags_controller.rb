class EnvironmentalSubtagsController < ApplicationController
  before_action :set_environmental_subtag, only: [:show, :edit, :update, :destroy]

  # GET /environmental_subtags
  # GET /environmental_subtags.json
  def index
    @environmental_subtags = EnvironmentalSubtag.all
  end

  # GET /environmental_subtags/1
  # GET /environmental_subtags/1.json
  def show
  end

  # GET /environmental_subtags/new
  def new
    @environmental_subtag = EnvironmentalSubtag.new
  end

  # GET /environmental_subtags/1/edit
  def edit
  end

  # POST /environmental_subtags
  # POST /environmental_subtags.json
  def create
    @environmental_subtag = EnvironmentalSubtag.new(environmental_subtag_params)

    respond_to do |format|
      if @environmental_subtag.save
        format.html { redirect_to @environmental_subtag, notice: 'Environmental subtag was successfully created.' }
        format.json { render :show, status: :created, location: @environmental_subtag }
      else
        format.html { render :new }
        format.json { render json: @environmental_subtag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /environmental_subtags/1
  # PATCH/PUT /environmental_subtags/1.json
  def update
    respond_to do |format|
      if @environmental_subtag.update(environmental_subtag_params)
        format.html { redirect_to @environmental_subtag, notice: 'Environmental subtag was successfully updated.' }
        format.json { render :show, status: :ok, location: @environmental_subtag }
      else
        format.html { render :edit }
        format.json { render json: @environmental_subtag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /environmental_subtags/1
  # DELETE /environmental_subtags/1.json
  def destroy
    @environmental_subtag.destroy
    respond_to do |format|
      format.html { redirect_to environmental_subtags_url, notice: 'Environmental subtag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    EnvironmentalSubtag.import(params[:file])
    redirect_to environmental_subtags_path, notice: 'Environmental Subtags imported.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_environmental_subtag
      @environmental_subtag = EnvironmentalSubtag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def environmental_subtag_params
      params.require(:environmental_subtag).permit(:name, :environmental_tag_id)
    end
end
