class FinishMakesController < ApplicationController
  # GET /finish_makes
  # GET /finish_makes.json
  def index
    @finish_makes = FinishMake.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @finish_makes }
    end
  end

  # GET /finish_makes/1
  # GET /finish_makes/1.json
  def show
    @finish_make = FinishMake.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @finish_make }
    end
  end

  # GET /finish_makes/new
  # GET /finish_makes/new.json
  def new
    @finish_make = FinishMake.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @finish_make }
    end
  end

  # GET /finish_makes/1/edit
  def edit
    @finish_make = FinishMake.find(params[:id])
  end

  # POST /finish_makes
  # POST /finish_makes.json
  def create
    @finish_make = FinishMake.new(params[:finish_make])

    respond_to do |format|
      if @finish_make.save
        format.html { redirect_to @finish_make, notice: 'Finish make was successfully created.' }
        format.json { render json: @finish_make, status: :created, location: @finish_make }
      else
        format.html { render action: "new" }
        format.json { render json: @finish_make.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /finish_makes/1
  # PUT /finish_makes/1.json
  def update
    @finish_make = FinishMake.find(params[:id])

    respond_to do |format|
      if @finish_make.update_attributes(params[:finish_make])
        format.html { redirect_to @finish_make, notice: 'Finish make was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @finish_make.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /finish_makes/1
  # DELETE /finish_makes/1.json
  def destroy
    @finish_make = FinishMake.find(params[:id])
    @finish_make.destroy

    respond_to do |format|
      format.html { redirect_to finish_makes_url }
      format.json { head :no_content }
    end
  end
end
