class MaintenanceEventsController < ApplicationController
  layout 'binder'
  include UploadersHelper
  
  before_filter :load_binder, :only => [:index, :new]
  
  # GET /maintenance_events
  # GET /maintenance_events.json
  def index
    authorize! :read, @binder
    
    initialize_uploader(current_user.id, @binder.id, 'maintenanceEvents')
    
    @maintenance_events = MaintenanceEvent.where(:maintenance_item_id => params[:maintenance_item_id]).order("do_date DESC")
    @next_event = @maintenance_events.where(:completed_date => nil).first

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @maintenance_events }
      format.js
    end
  end

  # GET /maintenance_events/1
  # GET /maintenance_events/1.json
  def show
    @maintenance_event = MaintenanceEvent.find(params[:id])
    
    authorize! :read, @maintenance_event

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @maintenance_event }
    end
  end

  # GET /maintenance_events/new
  # GET /maintenance_events/new.json
  def new
    authorize! :create, @binder
    
    @maintenance_event = MaintenanceEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @maintenance_event }
    end
  end

  # GET /maintenance_events/1/edit
  def edit
    @maintenance_event = MaintenanceEvent.find(params[:id])
    
    authorize! :write, @maintenance_event
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /maintenance_events
  # POST /maintenance_events.json
  def create
    @maintenance_event = MaintenanceEvent.new(params[:maintenance_event])
    mi = MaintenanceItem.find(@maintenance_event.maintenance_item_id)
    binder = Binder.find(mi.binder_id)
    
    authorize! :create, binder

    respond_to do |format|
      if @maintenance_event.save
        format.html { redirect_to @maintenance_event, notice: 'Maintenance event was successfully created.' }
        format.json { render json: @maintenance_event, status: :created, location: @maintenance_event }
      else
        format.html { render action: "new" }
        format.json { render json: @maintenance_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /maintenance_events/1
  # PUT /maintenance_events/1.json
  def update
    @maintenance_event = MaintenanceEvent.find(params[:id])
    
    authorize! :write, @maintenance_event

    respond_to do |format|
      if @maintenance_event.update_attributes(params[:maintenance_event])
        mi = MaintenanceItem.find(@maintenance_event.maintenance_item_id)
        if (@maintenance_event.completed_date)
          mi.schedule_next_event
          me = mi.next_event
          if !current_user.has_role? :owner, me
            current_user.add_role :owner, me
          end
        end
        @maintenance_events = MaintenanceEvent.where(maintenance_item_id: @maintenance_event.maintenance_item_id).order("do_date DESC")
        @next_event = @maintenance_events.where(:completed_date => nil).first
        @binder = Binder.find(mi.binder_id)
        format.html { redirect_to @maintenance_event, notice: 'Maintenance event was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @maintenance_event.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /maintenance_events/1
  # DELETE /maintenance_events/1.json
  def destroy
    @maintenance_event = MaintenanceEvent.find(params[:id])
    
    authorize! :destroy, @maintenance_event
    
    @maintenance_event.destroy

    respond_to do |format|
      format.html { redirect_to maintenance_events_url }
      format.json { head :no_content }
      format.js
    end
  end
  
private
  def load_binder
    mi = MaintenanceItem.find(params[:maintenance_item_id]) 
    @binder = Binder.find(mi.binder_id)
  end

end
