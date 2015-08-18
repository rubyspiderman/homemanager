class InventoryItemTypesController < ApplicationController
  # GET /inventory_item_types
  # GET /inventory_item_types.json
  def index
    @inventory_item_types = InventoryItemType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventory_item_types }
    end
  end

  # GET /inventory_item_types/1
  # GET /inventory_item_types/1.json
  def show
    @inventory_item_type = InventoryItemType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_item_type }
    end
  end

  # GET /inventory_item_types/new
  # GET /inventory_item_types/new.json
  def new
    @inventory_item_type = InventoryItemType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory_item_type }
    end
  end

  # GET /inventory_item_types/1/edit
  def edit
    @inventory_item_type = InventoryItemType.find(params[:id])
  end

  # POST /inventory_item_types
  # POST /inventory_item_types.json
  def create
    @inventory_item_type = InventoryItemType.new(params[:inventory_item_type])

    respond_to do |format|
      if @inventory_item_type.save
        format.html { redirect_to @inventory_item_type, notice: 'Inventory item type was successfully created.' }
        format.json { render json: @inventory_item_type, status: :created, location: @inventory_item_type }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory_item_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_item_types/1
  # PUT /inventory_item_types/1.json
  def update
    @inventory_item_type = InventoryItemType.find(params[:id])

    respond_to do |format|
      if @inventory_item_type.update_attributes(params[:inventory_item_type])
        format.html { redirect_to @inventory_item_type, notice: 'Inventory item type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory_item_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_item_types/1
  # DELETE /inventory_item_types/1.json
  def destroy
    @inventory_item_type = InventoryItemType.find(params[:id])
    @inventory_item_type.destroy

    respond_to do |format|
      format.html { redirect_to inventory_item_types_url }
      format.json { head :no_content }
    end
  end
end
