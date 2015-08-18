class ApplianceModelsController < ApplicationController
  # GET /appliance_models
  # GET /appliance_models.json
  def index
    @appliance_models = ApplianceModel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @appliance_models }
    end
  end

  # GET /appliance_models/1
  # GET /appliance_models/1.json
  def show
    @appliance_model = ApplianceModel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @appliance_model }
    end
  end

  # GET /appliance_models/new
  # GET /appliance_models/new.json
  def new
    @appliance_model = ApplianceModel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @appliance_model }
    end
  end

  # GET /appliance_models/1/edit
  def edit
    @appliance_model = ApplianceModel.find(params[:id])
  end

  # POST /appliance_models
  # POST /appliance_models.json
  def create
    @appliance_model = ApplianceModel.new(params[:appliance_model])

    respond_to do |format|
      if @appliance_model.save
        format.html { redirect_to @appliance_model, notice: 'Appliance model was successfully created.' }
        format.json { render json: @appliance_model, status: :created, location: @appliance_model }
      else
        format.html { render action: "new" }
        format.json { render json: @appliance_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /appliance_models/1
  # PUT /appliance_models/1.json
  def update
    @appliance_model = ApplianceModel.find(params[:id])

    respond_to do |format|
      if @appliance_model.update_attributes(params[:appliance_model])
        format.html { redirect_to @appliance_model, notice: 'Appliance model was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @appliance_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appliance_models/1
  # DELETE /appliance_models/1.json
  def destroy
    @appliance_model = ApplianceModel.find(params[:id])
    @appliance_model.destroy

    respond_to do |format|
      format.html { redirect_to appliance_models_url }
      format.json { head :no_content }
    end
  end
end
