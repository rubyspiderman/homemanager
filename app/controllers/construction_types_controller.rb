class ConstructionTypesController < ApplicationController
  # GET /construction_types
  # GET /construction_types.json
  def index
    @construction_types = ConstructionType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @construction_types }
    end
  end

  # GET /construction_types/1
  # GET /construction_types/1.json
  def show
    @construction_type = ConstructionType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @construction_type }
    end
  end

  # GET /construction_types/new
  # GET /construction_types/new.json
  def new
    @construction_type = ConstructionType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @construction_type }
    end
  end

  # GET /construction_types/1/edit
  def edit
    @construction_type = ConstructionType.find(params[:id])
  end

  # POST /construction_types
  # POST /construction_types.json
  def create
    @construction_type = ConstructionType.new(params[:construction_type])

    respond_to do |format|
      if @construction_type.save
        format.html { redirect_to @construction_type, notice: 'Construction type was successfully created.' }
        format.json { render json: @construction_type, status: :created, location: @construction_type }
      else
        format.html { render action: "new" }
        format.json { render json: @construction_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /construction_types/1
  # PUT /construction_types/1.json
  def update
    @construction_type = ConstructionType.find(params[:id])

    respond_to do |format|
      if @construction_type.update_attributes(params[:construction_type])
        format.html { redirect_to @construction_type, notice: 'Construction type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @construction_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /construction_types/1
  # DELETE /construction_types/1.json
  def destroy
    @construction_type = ConstructionType.find(params[:id])
    @construction_type.destroy

    respond_to do |format|
      format.html { redirect_to construction_types_url }
      format.json { head :no_content }
    end
  end
end
