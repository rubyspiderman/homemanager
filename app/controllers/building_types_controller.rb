class BuildingTypesController < ApplicationController
  # GET /building_types
  # GET /building_types.json
  def index
    @building_types = BuildingType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @building_types }
    end
  end

  # GET /building_types/1
  # GET /building_types/1.json
  def show
    @building_type = BuildingType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @building_type }
    end
  end

  # GET /building_types/new
  # GET /building_types/new.json
  def new
    @building_type = BuildingType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @building_type }
    end
  end

  # GET /building_types/1/edit
  def edit
    @building_type = BuildingType.find(params[:id])
  end

  # POST /building_types
  # POST /building_types.json
  def create
    @building_type = BuildingType.new(params[:building_type])

    respond_to do |format|
      if @building_type.save
        format.html { redirect_to @building_type, notice: 'Building type was successfully created.' }
        format.json { render json: @building_type, status: :created, location: @building_type }
      else
        format.html { render action: "new" }
        format.json { render json: @building_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /building_types/1
  # PUT /building_types/1.json
  def update
    @building_type = BuildingType.find(params[:id])

    respond_to do |format|
      if @building_type.update_attributes(params[:building_type])
        format.html { redirect_to @building_type, notice: 'Building type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @building_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /building_types/1
  # DELETE /building_types/1.json
  def destroy
    @building_type = BuildingType.find(params[:id])
    @building_type.destroy

    respond_to do |format|
      format.html { redirect_to building_types_url }
      format.json { head :no_content }
    end
  end
end
