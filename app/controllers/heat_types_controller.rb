class HeatTypesController < ApplicationController
  # GET /heat_types
  # GET /heat_types.json
  def index
    @heat_types = HeatType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @heat_types }
    end
  end

  # GET /heat_types/1
  # GET /heat_types/1.json
  def show
    @heat_type = HeatType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @heat_type }
    end
  end

  # GET /heat_types/new
  # GET /heat_types/new.json
  def new
    @heat_type = HeatType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @heat_type }
    end
  end

  # GET /heat_types/1/edit
  def edit
    @heat_type = HeatType.find(params[:id])
  end

  # POST /heat_types
  # POST /heat_types.json
  def create
    @heat_type = HeatType.new(params[:heat_type])

    respond_to do |format|
      if @heat_type.save
        format.html { redirect_to @heat_type, notice: 'Heat type was successfully created.' }
        format.json { render json: @heat_type, status: :created, location: @heat_type }
      else
        format.html { render action: "new" }
        format.json { render json: @heat_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /heat_types/1
  # PUT /heat_types/1.json
  def update
    @heat_type = HeatType.find(params[:id])

    respond_to do |format|
      if @heat_type.update_attributes(params[:heat_type])
        format.html { redirect_to @heat_type, notice: 'Heat type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @heat_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heat_types/1
  # DELETE /heat_types/1.json
  def destroy
    @heat_type = HeatType.find(params[:id])
    @heat_type.destroy

    respond_to do |format|
      format.html { redirect_to heat_types_url }
      format.json { head :no_content }
    end
  end
end
