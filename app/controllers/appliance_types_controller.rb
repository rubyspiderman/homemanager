class ApplianceTypesController < ApplicationController
  # GET /appliance_types
  # GET /appliance_types.json
  def index
    @appliance_types = ApplianceType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @appliance_types }
    end
  end

  # GET /appliance_types/1
  # GET /appliance_types/1.json
  def show
    @appliance_type = ApplianceType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @appliance_type }
    end
  end

  # GET /appliance_types/new
  # GET /appliance_types/new.json
  def new
    @appliance_type = ApplianceType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @appliance_type }
    end
  end

  # GET /appliance_types/1/edit
  def edit
    @appliance_type = ApplianceType.find(params[:id])
  end

  # POST /appliance_types
  # POST /appliance_types.json
  def create
    @appliance_type = ApplianceType.new(params[:appliance_type])

    respond_to do |format|
      if @appliance_type.save
        format.html { redirect_to @appliance_type, notice: 'Appliance type was successfully created.' }
        format.json { render json: @appliance_type, status: :created, location: @appliance_type }
      else
        format.html { render action: "new" }
        format.json { render json: @appliance_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /appliance_types/1
  # PUT /appliance_types/1.json
  def update
    @appliance_type = ApplianceType.find(params[:id])

    respond_to do |format|
      if @appliance_type.update_attributes(params[:appliance_type])
        format.html { redirect_to @appliance_type, notice: 'Appliance type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @appliance_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appliance_types/1
  # DELETE /appliance_types/1.json
  def destroy
    @appliance_type = ApplianceType.find(params[:id])
    @appliance_type.destroy

    respond_to do |format|
      format.html { redirect_to appliance_types_url }
      format.json { head :no_content }
    end
  end
end
