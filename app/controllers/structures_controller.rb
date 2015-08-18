class StructuresController < ApplicationController
  layout 'binder'
  include UploadersHelper
  
  before_filter :load_binder, :only => [:index, :new]
  before_filter :verify_subscription, :only => [:index, :show]
  
  # GET /structures
  # GET /structures.json
  def index
    authorize! :read, @binder
    
    initialize_uploader(current_user.id, @binder.id, 'structures')
      
    @structures = @binder.structures.order("name")
    @count = @structures.count
      
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @structures }
    end 
  end
  
  # GET /structures/1
  # GET /structures/1.json
  def show
    @structure = Structure.find(params[:id])
    
    authorize! :read, @structure 

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @structure }
    end
  end

  # GET /structures/new
  # GET /structures/new.json
  def new
    authorize! :create, @binder
    
    @structure = Structure.new(binder_id: @binder.id, created_by: current_user.id)
  
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @structure }
      format.js
    end
  end

  # GET /structures/1/edit
  def edit
    @structure = Structure.find(params[:id])
    
    authorize! :write, @structure
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /structures
  # POST /structures.json
  def create
    @structure  = Structure.new(params[:structure])
    @binder = Binder.find(@structure.binder_id)
    
    authorize! :create, @binder
    
    respond_to do |format|
      if @structure.save
        @structures = Structure.where(:binder_id => @structure.binder_id).order("name")
        format.html { redirect_to binder_structures_path(Binder.find(@structure.binder_id)), notice: 'Structure was successfully created.' }
        format.json { render json: @structure, status: :created, location: @structure }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @structure.errors, status: :unprocessable_entity }
        format.js 
      end
    end
  end

  # PUT /structures/1
  # PUT /structures/1.json
  def update
    @structure = Structure.find(params[:id])
    @binder = Binder.find(@structure.binder_id)
    
    authorize! :write, @structure
    
    respond_to do |format|
      if @structure.update_attributes(params[:structure])
        @structures = Structure.where(:binder_id => @structure.binder_id).order("name")
        format.html { redirect_to binder_structures_path(Binder.find(@structure.binder_id)), notice: 'Structure was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @structure.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /structures/1
  # DELETE /structures/1.json
  def destroy
    @structure = Structure.find(params[:id])
    @binder = Binder.find(@structure.binder_id)
    
    authorize! :destroy, @structure
    
    binder_id = @structure.binder_id
    @structure.destroy
    @structures = Structure.where(:binder_id => binder_id).order("name")
  
    respond_to do |format|
      format.html { redirect_to binder_structures_path(Binder.find(binder_id)) }
      format.json { head :no_content }
      format.js
    end
  end
  
end
