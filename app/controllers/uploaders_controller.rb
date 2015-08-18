class UploadersController < ApplicationController  
  # GET /uploaders
  # GET /uploaders.json
  def index
    @uploaders = Uploader.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @uploaders }
    end
  end

  # GET /uploaders/1
  # GET /uploaders/1.json
  def show
    @uploader = Uploader.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @uploader }
    end
  end

  # GET /uploaders/new
  # GET /uploaders/new.json
  def new
    @uploader = Uploader.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @uploader }
    end
  end

  # GET /uploaders/1/edit
  def edit
    @uploader = Uploader.find(params[:id])
  end

  # POST /uploaders
  # POST /uploaders.json
  def create
    @uploader = Uploader.new(params[:uploader])

    respond_to do |format|
      if @uploader.save
        format.html { redirect_to @uploader, notice: 'Uploader was successfully created.' }
        format.json { render json: @uploader, status: :created, location: @uploader }
      else
        format.html { render action: "new" }
        format.json { render json: @uploader.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /uploaders/1
  # PUT /uploaders/1.json
  def update
    @uploader = Uploader.find(params[:id])

    respond_to do |format|
      if @uploader.update_attributes(params[:uploader])
        format.html { redirect_to @uploader, notice: 'Uploader was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @uploader.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploaders/1
  # DELETE /uploaders/1.json
  def destroy
    @uploader = Uploader.find(params[:id])
    @uploader.destroy

    respond_to do |format|
      format.html { redirect_to uploaders_url }
      format.json { head :no_content }
    end
  end
end
