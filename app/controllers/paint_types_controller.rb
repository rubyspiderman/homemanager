class PaintTypesController < ApplicationController
  # GET /paint_types
  # GET /paint_types.json
  def index
    @paint_types = PaintType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @paint_types }
    end
  end

  # GET /paint_types/1
  # GET /paint_types/1.json
  def show
    @paint_type = PaintType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @paint_type }
    end
  end

  # GET /paint_types/new
  # GET /paint_types/new.json
  def new
    @paint_type = PaintType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @paint_type }
    end
  end

  # GET /paint_types/1/edit
  def edit
    @paint_type = PaintType.find(params[:id])
  end

  # POST /paint_types
  # POST /paint_types.json
  def create
    @paint_type = PaintType.new(params[:paint_type])

    respond_to do |format|
      if @paint_type.save
        format.html { redirect_to @paint_type, notice: 'Paint type was successfully created.' }
        format.json { render json: @paint_type, status: :created, location: @paint_type }
      else
        format.html { render action: "new" }
        format.json { render json: @paint_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /paint_types/1
  # PUT /paint_types/1.json
  def update
    @paint_type = PaintType.find(params[:id])

    respond_to do |format|
      if @paint_type.update_attributes(params[:paint_type])
        format.html { redirect_to @paint_type, notice: 'Paint type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @paint_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paint_types/1
  # DELETE /paint_types/1.json
  def destroy
    @paint_type = PaintType.find(params[:id])
    @paint_type.destroy

    respond_to do |format|
      format.html { redirect_to paint_types_url }
      format.json { head :no_content }
    end
  end
end
