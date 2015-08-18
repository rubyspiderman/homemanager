class ImagesController < ApplicationController
  
  require "s3"
  
  before_filter :load_imageable
  
  # GET /images
  # GET /images.json
  def index
    if working_binder.subscription.plan_id == 'free'
      render 'public/401.html', status: :unauthorized
      return
    end
    
    @images = @imageable.images

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @images }
      format.js
    end
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @image = Image.find(params[:id])
    
    if working_binder.subscription.plan_id == 'free'
      render 'public/401.html', status: :unauthorized
      return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/new
  # GET /images/new.json
  def new
    @image = @imageable.images.new(created_by: working_user.id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @image }
      format.js
    end
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /images
  # POST /images.json
  def create
    @image = @imageable.images.new(params[:image])
    @image.created_by = working_user.id

    respond_to do |format|
      if @image.save
        @images = @imageable.images
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render json: @image, status: :created, location: @image }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /images/1
  # PUT /images/1.json
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image = Image.find(params[:id])
    @deleteId = @image.id
    @image.destroy

    respond_to do |format|
      format.html { redirect_to images_url }
      format.json { head :no_content }
      format.js
    end
  end
  
private
 
  def load_imageable
    resource, id = request.path.split('/')[1, 2]
    @imageable = resource.singularize.classify.constantize.find(id)
  end

  def find_imageable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end 
end
