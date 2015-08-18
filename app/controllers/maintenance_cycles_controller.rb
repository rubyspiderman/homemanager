class MaintenanceCyclesController < ApplicationController
  # GET /maintenance_cycles
  # GET /maintenance_cycles.json
  def index
    @maintenance_cycles = MaintenanceCycle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @maintenance_cycles }
    end
  end

  # GET /maintenance_cycles/1
  # GET /maintenance_cycles/1.json
  def show
    @maintenance_cycle = MaintenanceCycle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @maintenance_cycle }
    end
  end

  # GET /maintenance_cycles/new
  # GET /maintenance_cycles/new.json
  def new
    @maintenance_cycle = MaintenanceCycle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @maintenance_cycle }
    end
  end

  # GET /maintenance_cycles/1/edit
  def edit
    @maintenance_cycle = MaintenanceCycle.find(params[:id])
  end

  # POST /maintenance_cycles
  # POST /maintenance_cycles.json
  def create
    @maintenance_cycle = MaintenanceCycle.new(params[:maintenance_cycle])

    respond_to do |format|
      if @maintenance_cycle.save
        format.html { redirect_to @maintenance_cycle, notice: 'Maintenance cycle was successfully created.' }
        format.json { render json: @maintenance_cycle, status: :created, location: @maintenance_cycle }
      else
        format.html { render action: "new" }
        format.json { render json: @maintenance_cycle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /maintenance_cycles/1
  # PUT /maintenance_cycles/1.json
  def update
    @maintenance_cycle = MaintenanceCycle.find(params[:id])

    respond_to do |format|
      if @maintenance_cycle.update_attributes(params[:maintenance_cycle])
        format.html { redirect_to @maintenance_cycle, notice: 'Maintenance cycle was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @maintenance_cycle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintenance_cycles/1
  # DELETE /maintenance_cycles/1.json
  def destroy
    @maintenance_cycle = MaintenanceCycle.find(params[:id])
    @maintenance_cycle.destroy

    respond_to do |format|
      format.html { redirect_to maintenance_cycles_url }
      format.json { head :no_content }
    end
  end
end
