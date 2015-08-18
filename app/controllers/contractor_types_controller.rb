class ContractorTypesController < ApplicationController
  # GET /contractor_types
  # GET /contractor_types.json
  def index
    @contractor_types = ContractorType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contractor_types }
    end
  end

  # GET /contractor_types/1
  # GET /contractor_types/1.json
  def show
    @contractor_type = ContractorType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contractor_type }
    end
  end

  # GET /contractor_types/new
  # GET /contractor_types/new.json
  def new
    @contractor_type = ContractorType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contractor_type }
    end
  end

  # GET /contractor_types/1/edit
  def edit
    @contractor_type = ContractorType.find(params[:id])
  end

  # POST /contractor_types
  # POST /contractor_types.json
  def create
    @contractor_type = ContractorType.new(params[:contractor_type])

    respond_to do |format|
      if @contractor_type.save
        format.html { redirect_to @contractor_type, notice: 'Contractor type was successfully created.' }
        format.json { render json: @contractor_type, status: :created, location: @contractor_type }
      else
        format.html { render action: "new" }
        format.json { render json: @contractor_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contractor_types/1
  # PUT /contractor_types/1.json
  def update
    @contractor_type = ContractorType.find(params[:id])

    respond_to do |format|
      if @contractor_type.update_attributes(params[:contractor_type])
        format.html { redirect_to @contractor_type, notice: 'Contractor type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contractor_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contractor_types/1
  # DELETE /contractor_types/1.json
  def destroy
    @contractor_type = ContractorType.find(params[:id])
    @contractor_type.destroy

    respond_to do |format|
      format.html { redirect_to contractor_types_url }
      format.json { head :no_content }
    end
  end
end
