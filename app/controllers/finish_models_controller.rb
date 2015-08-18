class FinishModelsController < ApplicationController
  # GET /finish_models
  # GET /finish_models.json
  def index
    @finish_models = FinishModel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @finish_models }
    end
  end

  # GET /finish_models/1
  # GET /finish_models/1.json
  def show
    @finish_model = FinishModel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @finish_model }
    end
  end

  # GET /finish_models/new
  # GET /finish_models/new.json
  def new
    @finish_model = FinishModel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @finish_model }
    end
  end

  # GET /finish_models/1/edit
  def edit
    @finish_model = FinishModel.find(params[:id])
  end

  # POST /finish_models
  # POST /finish_models.json
  def create
    @finish_model = FinishModel.new(params[:finish_model])

    respond_to do |format|
      if @finish_model.save
        format.html { redirect_to @finish_model, notice: 'Finish model was successfully created.' }
        format.json { render json: @finish_model, status: :created, location: @finish_model }
      else
        format.html { render action: "new" }
        format.json { render json: @finish_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /finish_models/1
  # PUT /finish_models/1.json
  def update
    @finish_model = FinishModel.find(params[:id])

    respond_to do |format|
      if @finish_model.update_attributes(params[:finish_model])
        format.html { redirect_to @finish_model, notice: 'Finish model was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @finish_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /finish_models/1
  # DELETE /finish_models/1.json
  def destroy
    @finish_model = FinishModel.find(params[:id])
    @finish_model.destroy

    respond_to do |format|
      format.html { redirect_to finish_models_url }
      format.json { head :no_content }
    end
  end
end
