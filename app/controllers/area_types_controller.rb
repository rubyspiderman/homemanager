class AreaTypesController < ApplicationController
  # GET /area_types
  # GET /area_types.json
  def index
    @area_types = AreaType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @area_types }
    end
  end

  # GET /area_types/1
  # GET /area_types/1.json
  def show
    @area_type = AreaType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @area_type }
    end
  end

  # GET /area_types/new
  # GET /area_types/new.json
  def new
    @area_type = AreaType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @area_type }
    end
  end

  # GET /area_types/1/edit
  def edit
    @area_type = AreaType.find(params[:id])
  end

  # POST /area_types
  # POST /area_types.json
  def create
    @area_type = AreaType.new(params[:area_type])

    respond_to do |format|
      if @area_type.save
        format.html { redirect_to @area_type, notice: 'Area type was successfully created.' }
        format.json { render json: @area_type, status: :created, location: @area_type }
      else
        format.html { render action: "new" }
        format.json { render json: @area_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /area_types/1
  # PUT /area_types/1.json
  def update
    @area_type = AreaType.find(params[:id])

    respond_to do |format|
      if @area_type.update_attributes(params[:area_type])
        format.html { redirect_to @area_type, notice: 'Area type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @area_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /area_types/1
  # DELETE /area_types/1.json
  def destroy
    @area_type = AreaType.find(params[:id])
    @area_type.destroy

    respond_to do |format|
      format.html { redirect_to area_types_url }
      format.json { head :no_content }
    end
  end
end
