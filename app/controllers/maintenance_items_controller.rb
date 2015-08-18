class MaintenanceItemsController < ApplicationController
  layout 'binder'
  include UploadersHelper
  
  before_filter :load_binder, :only => [:index, :new]
  before_filter :verify_subscription, :only => [:index, :show]
  
  # GET /maintenance_items
  # GET /maintenance_items.json
  def index
    authorize! :read, @binder
    
    initialize_uploader(current_user.id, @binder.id, 'maintenanceItems')
    
    @maintenance_items = @binder.maintenance_items.order("name")
    @count = @maintenance_items.count

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @maintenance_items }
    end
  end

  # GET /maintenance_items/1
  # GET /maintenance_items/1.json
  def show
    @maintenance_item = MaintenanceItem.find(params[:id])
    
    authorize! :read, @maintenance_item

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @maintenance_item }
    end
  end

  # GET /maintenance_items/new
  # GET /maintenance_items/new.json
  def new
    authorize! :create, @binder
    
    @maintenance_item = MaintenanceItem.new(
      binder_id: @binder.id, 
      created_by: current_user.id, 
      interval: 1, 
      maintenance_cycle_id: MaintenanceCycle.where(:name => 'Years').first.id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @maintenance_item }
      format.js
    end
  end

  # GET /maintenance_items/1/edit
  def edit
    @maintenance_item = MaintenanceItem.find(params[:id])
    
    authorize! :write, @maintenance_item
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /maintenance_items
  # POST /maintenance_items.json
  def create
    @maintenance_item = MaintenanceItem.new(params[:maintenance_item])
    @binder = Binder.find(@maintenance_item.binder_id)
    
    authorize! :create, @binder

    respond_to do |format|
      if @maintenance_item.save
        @maintenance_items = MaintenanceItem.where(:binder_id => @maintenance_item.binder_id).order("name")
        format.html { redirect_to binder_maintenance_items_path(working_binder), notice: 'Maintenance item was successfully created.' }
        format.json { render json: @maintenance_item, status: :created, location: @maintenance_item }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @maintenance_item.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /maintenance_items/1
  # PUT /maintenance_items/1.json
  def update
    @maintenance_item = MaintenanceItem.find(params[:id])
    @binder = Binder.find(@maintenance_item.binder_id)
    
    authorize! :write, @maintenance_item

    respond_to do |format|
      if @maintenance_item.update_attributes(params[:maintenance_item])
        @maintenance_items = MaintenanceItem.where(:binder_id => @maintenance_item.binder_id).order("name")
        format.html { redirect_to binder_maintenance_items_path(Binder.find(@maintenance_item.binder_id)), notice: 'Maintenance item was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @maintenance_item.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /maintenance_items/1
  # DELETE /maintenance_items/1.json
  def destroy
    @maintenance_item = MaintenanceItem.find(params[:id])
    @binder = Binder.find(@maintenance_item.binder_id)
    
    authorize! :destroy, @maintenance_item
    
    binder_id = @maintenance_item.binder_id
    @maintenance_item.destroy
    @maintenance_items = MaintenanceItem.where(:binder_id => binder_id).order("name")

    respond_to do |format|
      format.html { redirect_to binder_maintenance_items_path(Binder.find(binder_id)) }
      format.json { head :no_content }
      format.js
    end
  end
  
end
