class BinderContractorsController < ApplicationController
  layout 'binder'
  include UploadersHelper
  
  before_filter :load_binder, :only => [:index, :new]
  before_filter :verify_subscription, :only => [:index, :show]
  
  # GET /binder_contractors
  # GET /binder_contractors.json
  def index
    authorize! :read, @binder
    initialize_uploader(current_user.id, @binder.id, 'binder_contractors')
    
    @binder_contractors = working_binder.binder_contractors
    @count = @binder_contractors.count

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @binder_contractors }
    end
  end

  # GET /binder_contractors/1
  # GET /binder_contractors/1.json
  def show
    @binder_contractor = BinderContractor.find(params[:id])
    
    authorize! :read, @binder_contractor

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @binder_contractor }
    end
  end

  # GET /binder_contractors/new
  # GET /binder_contractors/new.json
  def new
    authorize! :create, @binder
    
    @binder_contractor = BinderContractor.new(binder_id: @binder.id, created_by: current_user.id)
    @binder_contractor.build_contractor(created_by: current_user.id, verified: false)
    @binder_contractor.contractor.build_address(state: @binder.property.state)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @binder_contractor }
      format.js
    end
  end

  # GET /binder_contractors/1/edit
  def edit
    @binder_contractor = BinderContractor.find(params[:id])
    
    authorize! :write, @binder_contractor
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /binder_contractors
  # POST /binder_contractors.json
  def create
    @binder_contractor = BinderContractor.new(params[:binder_contractor])
    @binder = Binder.find(@binder_contractor.binder_id)
    authorize! :create, @binder

    respond_to do |format|
      if @binder_contractor.save
        @binder_contractors = working_binder.binder_contractors
        format.html { redirect_to @binder_contractor, notice: 'Binder contractor was successfully created.' }
        format.json { render json: @binder_contractor, status: :created, location: @binder_contractor }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @binder_contractor.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /binder_contractors/1
  # PUT /binder_contractors/1.json
  def update
    @binder_contractor = BinderContractor.find(params[:id])
    @binder = Binder.find(@binder_contractor.binder_id)
    authorize! :write, @binder

    respond_to do |format|
      if @binder_contractor.update_attributes(params[:binder_contractor])
        @binder_contractors = working_binder.binder_contractors
        format.html { redirect_to @binder_contractor, notice: 'Binder contractor was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @binder_contractor.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /binder_contractors/1
  # DELETE /binder_contractors/1.json
  def destroy
    @binder_contractor = BinderContractor.find(params[:id])
    @binder = Binder.find(@binder_contractor.binder_id)
    
    authorize! :destroy, @binder_contractor
    
    @deleteId = @binder_contractor.id
    @binder_contractor.destroy
    @binder_contractors = working_binder.binder_contractors
    
    respond_to do |format|
      format.html { redirect_to binder_contractors_url }
      format.json { head :no_content }
      format.js
    end
  end
end
