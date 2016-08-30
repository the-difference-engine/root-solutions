class EnvironmentalTagsController < ApplicationController
  before_action :set_environmental_tag, only: [:show, :edit, :update, :destroy]

  # GET /environmental_tags
  # GET /environmental_tags.json
  def index
    @environmental_tags = EnvironmentalTag.all
  end

  # GET /environmental_tags/1
  # GET /environmental_tags/1.json
  def show
  end

  # GET /environmental_tags/new
  def new
    @environmental_tag = EnvironmentalTag.new
  end

  # GET /environmental_tags/1/edit
  def edit
  end

  # POST /environmental_tags
  # POST /environmental_tags.json
  def create
    @environmental_tag = EnvironmentalTag.new(environmental_tag_params)

    respond_to do |format|
      if @environmental_tag.save
        format.html { redirect_to @environmental_tag, notice: 'Environmental tag was successfully created.' }
        format.json { render :show, status: :created, location: @environmental_tag }
      else
        format.html { render :new }
        format.json { render json: @environmental_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /environmental_tags/1
  # PATCH/PUT /environmental_tags/1.json
  def update
    respond_to do |format|
      if @environmental_tag.update(environmental_tag_params)
        format.html { redirect_to @environmental_tag, notice: 'Environmental tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @environmental_tag }
      else
        format.html { render :edit }
        format.json { render json: @environmental_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /environmental_tags/1
  # DELETE /environmental_tags/1.json
  def destroy
    @environmental_tag.destroy
    respond_to do |format|
      format.html { redirect_to environmental_tags_path, notice: 'Environmental tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    EnvironmentalTag.import(params[:file])
    redirect_to environmental_tags_path, notice: 'Environmental Tags imported.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_environmental_tag
      @environmental_tag = EnvironmentalTag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def environmental_tag_params
      params.require(:environmental_tag).permit(:name)
    end
end
