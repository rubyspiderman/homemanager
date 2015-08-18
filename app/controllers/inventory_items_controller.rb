class InventoryItemsController < ApplicationController
  layout 'binder'
  include UploadersHelper
  
  before_filter :load_binder, :only => [:index, :new]
  before_filter :verify_subscription, :only => [:index, :show]
  
  # GET /inventory_items
  # GET /inventory_items.json
  def index
    authorize! :read, @binder
    
    initialize_uploader(current_user.id, @binder.id, 'inventory')
   
    @inventory_items = working_binder.inventory_items
    @count = @inventory_items.count

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventory_items }
    end
  end

  # GET /inventory_items/1
  # GET /inventory_items/1.json
  def show
    @inventory_item = InventoryItem.find(params[:id])
    
    authorize! :read, @inventory_item

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_item }
    end
  end

  # GET /inventory_items/new
  # GET /inventory_items/new.json
  def new
    authorize! :create, @binder
    
    @inventory_item = InventoryItem.new(binder_id: working_binder.id, created_by: current_user.id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory_item }
      format.js
    end
  end

  # GET /inventory_items/1/edit
  def edit
    @inventory_item = InventoryItem.find(params[:id])
    
    authorize! :write, @inventory_item
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /inventory_items
  # POST /inventory_items.json
  def create
    @inventory_item = InventoryItem.new(params[:inventory_item])
    @binder = Binder.find(@inventory_item.binder_id)
    
    authorize! :create, @binder

    respond_to do |format|
      if @inventory_item.save
        @inventory_items = InventoryItem.where(:binder_id => @inventory_item.binder_id).order("name")
        format.html { redirect_to @inventory_item, notice: 'Inventory item was successfully created.' }
        format.json { render json: @inventory_item, status: :created, location: @inventory_item }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @inventory_item.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /inventory_items/1
  # PUT /inventory_items/1.json
  def update
    @inventory_item = InventoryItem.find(params[:id])
    @binder = Binder.find(@inventory_item.binder_id)
    
    authorize! :write, @inventory_item

    respond_to do |format|
      if @inventory_item.update_attributes(params[:inventory_item])
        @inventory_items = InventoryItem.where(:binder_id => @inventory_item.binder_id).order("name")
        format.html { redirect_to @inventory_item, notice: 'Inventory item was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory_item.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /inventory_items/1
  # DELETE /inventory_items/1.json
  def destroy
    @inventory_item = InventoryItem.find(params[:id])
    @binder = Binder.find(@inventory_item.binder_id)
    
    authorize! :destroy, @inventory_item
    
    binder_id = @inventory_item.binder_id
    @inventory_item.destroy
    @inventory_items = InventoryItem.where(:binder_id => binder_id).order("name")

    respond_to do |format|
      format.html { redirect_to inventory_items_url }
      format.json { head :no_content }
      format.js
    end
  end
  
end
