class AreasController < ApplicationController
  layout 'binder'
  include UploadersHelper
  
  before_filter :load_binder, :only => [:index, :new]
  before_filter :verify_subscription, :only => [:index, :show]
  
  # GET /areas
  # GET /areas.json
  def index
    authorize! :read, @binder
    
    initialize_uploader(current_user.id, @binder.id, 'areas')
    
    @areas = @binder.areas.order("name")
    @count = @areas.count

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @areas }
    end
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
    @area = Area.find(params[:id])
    
    authorize! :read, @area

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @area }
    end
  end

  # GET /areas/new
  # GET /areas/new.json
  def new
    authorize! :create, @binder
    
    @area = Area.new(binder_id: @binder.id, created_by: current_user.id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @area }
      format.js
    end
  end

  # GET /areas/1/edit
  def edit
    @area = Area.find(params[:id])
    
    authorize! :write, @area
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(params[:area])
    @binder = Binder.find(@area.binder_id)
    
    authorize! :create, @binder
    
    respond_to do |format|
      if @area.save
        @areas = Area.where(:binder_id => @area.binder_id).order("name")
        format.html { redirect_to binder_areas_path(Binder.find(@area.binder_id)), notice: 'Area was successfully created.' }
        format.json { render json: @area, status: :created, location: @area }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @area.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /areas/1
  # PUT /areas/1.json
  def update
    @area = Area.find(params[:id])
    @binder = Binder.find(@area.binder_id)
    
    authorize! :write, @area
    
    respond_to do |format|
      if @area.update_attributes(params[:area])
        @areas = Area.where(:binder_id => @area.binder_id).order("name")
        format.html { redirect_to binder_areas_path(Binder.find(@area.binder_id)), notice: 'Area was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @area.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area = Area.find(params[:id])
    @binder = Binder.find(@area.binder_id)
    
    authorize! :destroy, @area
    
    binder_id = @area.binder_id
    @area.destroy
    @areas = Area.where(:binder_id => binder_id).order("name")

    respond_to do |format|
      format.html { redirect_to binder_areas_path(Binder.find(binder_id)) }
      format.json { head :no_content }
      format.js
    end
  end
end
