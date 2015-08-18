class PaintManufacturersController < ApplicationController
  # GET /paint_manufacturers
  # GET /paint_manufacturers.json
  def index
    @paint_manufacturers = PaintManufacturer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @paint_manufacturers }
    end
  end

  # GET /paint_manufacturers/1
  # GET /paint_manufacturers/1.json
  def show
    @paint_manufacturer = PaintManufacturer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @paint_manufacturer }
    end
  end

  # GET /paint_manufacturers/new
  # GET /paint_manufacturers/new.json
  def new
    @paint_manufacturer = PaintManufacturer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @paint_manufacturer }
    end
  end

  # GET /paint_manufacturers/1/edit
  def edit
    @paint_manufacturer = PaintManufacturer.find(params[:id])
  end

  # POST /paint_manufacturers
  # POST /paint_manufacturers.json
  def create
    @paint_manufacturer = PaintManufacturer.new(params[:paint_manufacturer])

    respond_to do |format|
      if @paint_manufacturer.save
        format.html { redirect_to @paint_manufacturer, notice: 'Paint manufacturer was successfully created.' }
        format.json { render json: @paint_manufacturer, status: :created, location: @paint_manufacturer }
      else
        format.html { render action: "new" }
        format.json { render json: @paint_manufacturer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /paint_manufacturers/1
  # PUT /paint_manufacturers/1.json
  def update
    @paint_manufacturer = PaintManufacturer.find(params[:id])

    respond_to do |format|
      if @paint_manufacturer.update_attributes(params[:paint_manufacturer])
        format.html { redirect_to @paint_manufacturer, notice: 'Paint manufacturer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @paint_manufacturer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paint_manufacturers/1
  # DELETE /paint_manufacturers/1.json
  def destroy
    @paint_manufacturer = PaintManufacturer.find(params[:id])
    @paint_manufacturer.destroy

    respond_to do |format|
      format.html { redirect_to paint_manufacturers_url }
      format.json { head :no_content }
    end
  end
end
