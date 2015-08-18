class ContractorsController < ApplicationController
  layout 'binder'
  include UploadersHelper
  
  # GET /contractors
  # GET /contractors.json
  def index
    load_binder
    initialize_uploader(current_user.id, @binder.id, 'contractors')
    
    @contractors = working_binder.contractors
    @count = @contractors.count

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contractors }
    end
  end

  # GET /contractors/1
  # GET /contractors/1.json
  def show
    @contractor = Contractor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contractor }
    end
  end

  # GET /contractors/new
  # GET /contractors/new.json
  def new
    @contractor = Contractor.new(created_by: current_user.id, verified: false)
    @contractor.build_address

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contractor }
      format.js
    end
  end

  # GET /contractors/1/edit
  def edit
    @contractor = Contractor.find(params[:id])
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /contractors
  # POST /contractors.json
  def create
    @contractor = Contractor.new(params[:contractor])
    working_binder.contractors << @contractor

    respond_to do |format|
      if working_binder.save
        @contractors = working_binder.contractors
        format.html { redirect_to binder_contractors_path(working_binder), notice: 'Contractor was successfully created.' }
        format.json { render json: @contractor, status: :created, location: @contractor }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @contractor.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /contractors/1
  # PUT /contractors/1.json
  def update
    @contractor = Contractor.find(params[:id])

    respond_to do |format|
      if @contractor.update_attributes(params[:contractor])
        @contractors = working_binder.contractors
        format.html { redirect_to binder_contractors_path(working_binder), notice: 'Contractor was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @contractor.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /contractors/1
  # DELETE /contractors/1.json
  def destroy
    @contractor = Contractor.find(params[:id])
    working_binder.contractors.delete(@contractor)
    if @contractor.verified == false
      @contractor.destroy
    end
    @contractors = working_binder.contractors

    respond_to do |format|
      format.html { redirect_to binder_contractors_path(working_binder) }
      format.json { head :no_content }
      format.js
    end
  end
end
