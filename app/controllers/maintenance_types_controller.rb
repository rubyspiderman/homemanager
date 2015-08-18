class MaintenanceTypesController < ApplicationController
  # GET /maintenance_types
  # GET /maintenance_types.json
  def index
    @maintenance_types = MaintenanceType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @maintenance_types }
    end
  end

  # GET /maintenance_types/1
  # GET /maintenance_types/1.json
  def show
    @maintenance_type = MaintenanceType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @maintenance_type }
    end
  end

  # GET /maintenance_types/new
  # GET /maintenance_types/new.json
  def new
    @maintenance_type = MaintenanceType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @maintenance_type }
    end
  end

  # GET /maintenance_types/1/edit
  def edit
    @maintenance_type = MaintenanceType.find(params[:id])
  end

  # POST /maintenance_types
  # POST /maintenance_types.json
  def create
    @maintenance_type = MaintenanceType.new(params[:maintenance_type])

    respond_to do |format|
      if @maintenance_type.save
        format.html { redirect_to @maintenance_type, notice: 'Maintenance type was successfully created.' }
        format.json { render json: @maintenance_type, status: :created, location: @maintenance_type }
      else
        format.html { render action: "new" }
        format.json { render json: @maintenance_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /maintenance_types/1
  # PUT /maintenance_types/1.json
  def update
    @maintenance_type = MaintenanceType.find(params[:id])

    respond_to do |format|
      if @maintenance_type.update_attributes(params[:maintenance_type])
        format.html { redirect_to @maintenance_type, notice: 'Maintenance type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @maintenance_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintenance_types/1
  # DELETE /maintenance_types/1.json
  def destroy
    @maintenance_type = MaintenanceType.find(params[:id])
    @maintenance_type.destroy

    respond_to do |format|
      format.html { redirect_to maintenance_types_url }
      format.json { head :no_content }
    end
  end
end
