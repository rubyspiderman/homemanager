class ProjectsController < ApplicationController
  layout 'binder'
  include UploadersHelper
  
  before_filter :load_binder, :only => [:index, :new]
  before_filter :verify_subscription, :only => [:index, :show]
  
  # GET /projects
  # GET /projects.json
  def index
    authorize! :read, @binder
    
    initialize_uploader(current_user.id, @binder.id, 'projects')
    
    @projects = @binder.projects.order("name")
    @count = @projects.count

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    
    authorize! :read, @project

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    authorize! :create, @binder
    
    @project = Project.new(binder_id: @binder.id, created_by: current_user.id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
      format.js
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
    
    authorize! :write, @project
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])
    @binder = Binder.find(@project.binder_id)
    
    authorize! :create, @binder

    respond_to do |format|
      if @project.save
        @projects = Project.where(:binder_id => @project.binder_id).order("name")
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
        forma.js
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])
    @binder = Binder.find(@project.binder_id)
    
    authorize! :write, @project

    respond_to do |format|
      if @project.update_attributes(params[:project])
        @projects = Project.where(:binder_id => @project.binder_id).order("name")
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @binder = Binder.find(@project.binder_id)
    
    authorize! :destroy, @project
    
    binder_id = @project.binder_id
    @project.destroy
    @projects = Project.where(:binder_id => binder_id).order("name")

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
      format.js
    end
  end
end
