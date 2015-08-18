class AppliancesController < ApplicationController
  layout 'binder'
  include UploadersHelper
  
  before_filter :load_binder, :only => [:index, :new]
  before_filter :verify_subscription, :only => [:index, :show]
  
  # GET /appliances
  # GET /appliances.json
  def index
    authorize! :read, @binder
    
    initialize_uploader(current_user.id, @binder.id, 'appliances')
    
    @appliances = @binder.appliances.order("name")
    @count = @appliances.count

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @appliances }
    end
  end

  # GET /appliances/1
  # GET /appliances/1.json
  def show
    @appliance = Appliance.find(params[:id])
    
    authorize! :read, @appliance

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @appliance }
    end
  end

  # GET /appliances/new
  # GET /appliances/new.json
  def new
    authorize! :create, @binder
    
    @appliance = Appliance.new(binder_id: @binder.id, created_by: current_user.id)
    @appliance.build_purchase

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @appliance }
      format.js
    end
  end

  # GET /appliances/1/edit
  def edit
    @appliance = Appliance.find(params[:id])
    
    authorize! :write, @appliance
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /appliances
  # POST /appliances.json
  def create
    @appliance = Appliance.new(params[:appliance])
    @binder = Binder.find(@appliance.binder_id)
    
    authorize! :create, @binder
  
    respond_to do |format|
      if @appliance.save
        @appliances = Appliance.where(:binder_id => @appliance.binder_id).order("name")
        format.html { redirect_to binder_appliances_path(Binder.find(@appliance.binder_id)), notice: 'Appliance was successfully created.' }
        format.json { render json: @appliance, status: :created, location: @appliance }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @appliance.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /appliances/1
  # PUT /appliances/1.json
  def update
    @appliance = Appliance.find(params[:id])
    @binder = Binder.find(@appliance.binder_id)
    
    authorize! :write, @appliance

    respond_to do |format|
      if @appliance.update_attributes(params[:appliance])
        @appliances = Appliance.where(:binder_id => @appliance.binder_id).order("name")
        format.html { redirect_to binder_appliances_path(Binder.find(@appliance.binder_id)), notice: 'Appliance was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @appliance.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /appliances/1
  # DELETE /appliances/1.json
  def destroy
    @appliance = Appliance.find(params[:id])
    @binder = Binder.find(@appliance.binder_id)
    
    authorize! :destroy, @appliance
    
    binder_id = @appliance.binder_id
    @appliance.destroy
    @appliances = Appliance.where(:binder_id => binder_id).order("name")

    respond_to do |format|
      format.html { redirect_to binder_appliances_path(Binder.find(binder_id)) }
      format.json { head :no_content }
      format.js
    end
  end
  
end
