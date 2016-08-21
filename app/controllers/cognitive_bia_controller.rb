class CognitiveBiaController < ApplicationController
  before_action :set_cognitive_bium, only: [:show, :edit, :update, :destroy]

  # GET /cognitive_bia
  # GET /cognitive_bia.json
  def index
    @cognitive_bia = CognitiveBium.all
  end

  # GET /cognitive_bia/1
  # GET /cognitive_bia/1.json
  def show
  end

  # GET /cognitive_bia/new
  def new
    @cognitive_bium = CognitiveBium.new
  end

  # GET /cognitive_bia/1/edit
  def edit
  end

  # POST /cognitive_bia
  # POST /cognitive_bia.json
  def create
    @cognitive_bium = CognitiveBium.new(cognitive_bium_params)

    respond_to do |format|
      if @cognitive_bium.save
        format.html { redirect_to @cognitive_bium, notice: 'Cognitive bium was successfully created.' }
        format.json { render :show, status: :created, location: @cognitive_bium }
      else
        format.html { render :new }
        format.json { render json: @cognitive_bium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cognitive_bia/1
  # PATCH/PUT /cognitive_bia/1.json
  def update
    respond_to do |format|
      if @cognitive_bium.update(cognitive_bium_params)
        format.html { redirect_to @cognitive_bium, notice: 'Cognitive bium was successfully updated.' }
        format.json { render :show, status: :ok, location: @cognitive_bium }
      else
        format.html { render :edit }
        format.json { render json: @cognitive_bium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cognitive_bia/1
  # DELETE /cognitive_bia/1.json
  def destroy
    @cognitive_bium.destroy
    respond_to do |format|
      format.html { redirect_to cognitive_bia_url, notice: 'Cognitive bium was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    CognitiveBium.import(params[:file])
    redirect_to cognitive_bia_path, notice: 'Cognitive Bia imported.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cognitive_bium
      @cognitive_bium = CognitiveBium.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cognitive_bium_params
      params.require(:cognitive_bium).permit(:name)
    end
end
