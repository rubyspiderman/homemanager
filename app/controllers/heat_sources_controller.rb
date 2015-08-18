class HeatSourcesController < ApplicationController
  # GET /heat_sources
  # GET /heat_sources.json
  def index
    @heat_sources = HeatSource.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @heat_sources }
    end
  end

  # GET /heat_sources/1
  # GET /heat_sources/1.json
  def show
    @heat_source = HeatSource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @heat_source }
    end
  end

  # GET /heat_sources/new
  # GET /heat_sources/new.json
  def new
    @heat_source = HeatSource.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @heat_source }
    end
  end

  # GET /heat_sources/1/edit
  def edit
    @heat_source = HeatSource.find(params[:id])
  end

  # POST /heat_sources
  # POST /heat_sources.json
  def create
    @heat_source = HeatSource.new(params[:heat_source])

    respond_to do |format|
      if @heat_source.save
        format.html { redirect_to @heat_source, notice: 'Heat source was successfully created.' }
        format.json { render json: @heat_source, status: :created, location: @heat_source }
      else
        format.html { render action: "new" }
        format.json { render json: @heat_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /heat_sources/1
  # PUT /heat_sources/1.json
  def update
    @heat_source = HeatSource.find(params[:id])

    respond_to do |format|
      if @heat_source.update_attributes(params[:heat_source])
        format.html { redirect_to @heat_source, notice: 'Heat source was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @heat_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heat_sources/1
  # DELETE /heat_sources/1.json
  def destroy
    @heat_source = HeatSource.find(params[:id])
    @heat_source.destroy

    respond_to do |format|
      format.html { redirect_to heat_sources_url }
      format.json { head :no_content }
    end
  end
end
