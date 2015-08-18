class PaintsController < ApplicationController
  layout 'binder'
  include UploadersHelper
  
  before_filter :load_binder, :only => [:index, :new]
  before_filter :verify_subscription, :only => [:index, :show]
  
  # GET /paints
  # GET /paints.json
  def index
    authorize! :read, @binder
    
    initialize_uploader(current_user.id, @binder.id, 'paints')
    
    @paints = @binder.paints.order("name")
    @count = @paints.count

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @paints }
    end
  end

  # GET /paints/1
  # GET /paints/1.json
  def show
    @paint = Paint.find(params[:id])
    
    authorize! :read, @paint

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @paint }
    end
  end

  # GET /paints/new
  # GET /paints/new.json
  def new
    authorize! :create, @binder
    
    @paint = Paint.new(binder_id: @binder.id, created_by: current_user.id)
    @paint.build_purchase

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @paint }
      format.js
    end
  end

  # GET /paints/1/edit
  def edit
    @paint = Paint.find(params[:id])
    
    authorize! :write, @paint
    
    respond_to do |format|
      format.html 
      format.js
    end
  end

  # POST /paints
  # POST /paints.json
  def create
    @paint = Paint.new(params[:paint])
    @binder = Binder.find(@paint.binder_id)
    
    authorize! :create, @binder
    
    respond_to do |format|
      if @paint.save
        @paints = Paint.where(:binder_id => @paint.binder_id).order("name")
        format.html { redirect_to binder_paints_path(Binder.find(@paint.binder_id)), notice: 'Paint was successfully created.' }
        format.json { render json: @paint, status: :created, location: @paint }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @paint.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /paints/1
  # PUT /paints/1.json
  def update
    @paint = Paint.find(params[:id])
    @binder = Binder.find(@paint.binder_id)
    
    authorize! :write, @paint

    respond_to do |format|
      if @paint.update_attributes(params[:paint])
        @paints = Paint.where(:binder_id => @paint.binder_id).order("name")
        format.html { redirect_to Binder.find(@paint.binder_id), notice: 'Paint was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @paint.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /paints/1
  # DELETE /paints/1.json
  def destroy
    @paint = Paint.find(params[:id])
    @binder = Binder.find(@paint.binder_id)
    
    authorize! :write, @paint
    
    binder_id = @paint.binder_id
    @paint.destroy
    @paints = Paint.where(:binder_id => binder_id).order("name")
    
    respond_to do |format|
      format.html { redirect_to binder_paints_path(Binder.find(binder_id)) }
      format.json { head :no_content }
      format.js
    end
  end
end
