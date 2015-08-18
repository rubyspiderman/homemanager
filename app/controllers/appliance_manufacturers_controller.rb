class ApplianceManufacturersController < ApplicationController
  # GET /appliance_manufacturers
  # GET /appliance_manufacturers.json
  def index
    @appliance_manufacturers = ApplianceManufacturer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @appliance_manufacturers }
    end
  end

  # GET /appliance_manufacturers/1
  # GET /appliance_manufacturers/1.json
  def show
    @appliance_manufacturer = ApplianceManufacturer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @appliance_manufacturer }
    end
  end

  # GET /appliance_manufacturers/new
  # GET /appliance_manufacturers/new.json
  def new
    @appliance_manufacturer = ApplianceManufacturer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @appliance_manufacturer }
    end
  end

  # GET /appliance_manufacturers/1/edit
  def edit
    @appliance_manufacturer = ApplianceManufacturer.find(params[:id])
  end

  # POST /appliance_manufacturers
  # POST /appliance_manufacturers.json
  def create
    @appliance_manufacturer = ApplianceManufacturer.new(params[:appliance_manufacturer])

    respond_to do |format|
      if @appliance_manufacturer.save
        format.html { redirect_to @appliance_manufacturer, notice: 'Appliance manufacturer was successfully created.' }
        format.json { render json: @appliance_manufacturer, status: :created, location: @appliance_manufacturer }
      else
        format.html { render action: "new" }
        format.json { render json: @appliance_manufacturer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /appliance_manufacturers/1
  # PUT /appliance_manufacturers/1.json
  def update
    @appliance_manufacturer = ApplianceManufacturer.find(params[:id])

    respond_to do |format|
      if @appliance_manufacturer.update_attributes(params[:appliance_manufacturer])
        format.html { redirect_to @appliance_manufacturer, notice: 'Appliance manufacturer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @appliance_manufacturer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appliance_manufacturers/1
  # DELETE /appliance_manufacturers/1.json
  def destroy
    @appliance_manufacturer = ApplianceManufacturer.find(params[:id])
    @appliance_manufacturer.destroy

    respond_to do |format|
      format.html { redirect_to appliance_manufacturers_url }
      format.json { head :no_content }
    end
  end
end
