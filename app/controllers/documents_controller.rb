class DocumentsController < ApplicationController
  
   require "s3"
   
   before_filter :load_documentable
  
  # GET /documents
  # GET /documents.json
  def index
    if working_binder.subscription.plan_id == 'free'
      render 'public/401.html', status: :unauthorized
      return
    end
    
    @documents = @documentable.documents

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
      format.js
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @document = Document.find(params[:id])
    
    if working_binder.subscription.plan_id == 'free'
      render 'public/401.html', status: :unauthorized
      return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/new
  # GET /documents/new.json
  def new
    @document = @documentable.documents.new(created_by: working_user.id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document }
      format.js
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = @documentable.documents.new(params[:document])
    @document.created_by = working_user.id

    respond_to do |format|
      if @document.save
        @documents = @documentable.documents
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render json: @document, status: :created, location: @document }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def update
    @document = Document.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = Document.find(params[:id])
    @deleteId = @document.id 
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url }
      format.json { head :no_content }
      format.js
    end
  end
  
private
 
  def load_documentable
    resource, id = request.path.split('/')[1, 2]
    @documentable = resource.singularize.classify.constantize.find(id)
  end

  def find_documentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
