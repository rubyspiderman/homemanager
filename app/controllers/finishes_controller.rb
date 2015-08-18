class FinishesController < ApplicationController
  layout 'binder'
  include UploadersHelper
  
  before_filter :load_binder, :only => [:index, :new]
  before_filter :verify_subscription, :only => [:index, :show]
  
  # GET /finishes
  # GET /finishes.json
  def index
    authorize! :read, @binder
    
    initialize_uploader(current_user.id, @binder.id, 'finishes')
    
    @finishes = @binder.finishes.order("name")
    @count = @finishes.count

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @finishes }
    end
  end

  # GET /finishes/1
  # GET /finishes/1.json
  def show
    @finish = Finish.find(params[:id])
    
    authorize! :read, @finish

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @finish }
    end
  end

  # GET /finishes/new
  # GET /finishes/new.json
  def new
    authorize! :create, @binder
    
    @finish = Finish.new(binder_id: @binder.id, created_by: current_user.id)
    @finish.build_purchase

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @finish }
      format.js
    end
  end

  # GET /finishes/1/edit
  def edit
    @finish = Finish.find(params[:id])
    
    authorize! :write, @finish
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /finishes
  # POST /finishes.json
  def create
    @finish = Finish.new(params[:finish])
    @binder = Binder.find(@finish.binder_id)
    
    authorize! :create, @binder
    
    respond_to do |format|
      if @finish.save
        @finishes = Finish.where(:binder_id => @finish.binder_id).order("name")
        format.html { redirect_to binder_finishes_path(Binder.find(@finish.binder_id)), notice: 'Finish was successfully created.' }
        format.json { render json: @finish, status: :created, location: @finish }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @finish.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /finishes/1
  # PUT /finishes/1.json
  def update
    @finish = Finish.find(params[:id])
    @binder = Binder.find(@finish.binder_id)
    
    authorize! :write, @finish
    
    respond_to do |format|
      if @finish.update_attributes(params[:finish])
        @finishes = Finish.where(:binder_id => @finish.binder_id).order("name")
        format.html { redirect_to binder_finishes_path(Binder.find(@finish.binder_id)), notice: 'Finish was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @finish.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /finishes/1
  # DELETE /finishes/1.json
  def destroy
    @finish = Finish.find(params[:id])
    @binder = Binder.find(@finish.binder_id)
    
    authorize! :destroy, @finish
    
    binder_id = @finish.binder_id
    @finish.destroy
    @finishes = Finish.where(:binder_id => binder_id).order("name")

    respond_to do |format|
      format.html { redirect_to binder_finishes_path(Binder.find(binder_id)) }
      format.json { head :no_content }
      format.js
    end
  end
end
