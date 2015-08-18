class NotesController < ApplicationController
  
  before_filter :load_notable
  
  # GET /notes
  # GET /notes.json
  def index
    @notes = @notable.notes

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notes }
      format.js
    end
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @note = Note.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @note }
    end
  end

  # GET /notes/new
  # GET /notes/new.json
  def new
    @note = @notable.notes.new(created_by: working_user.id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @note }
      format.js
    end
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = @notable.notes.new(params[:note])
    
    respond_to do |format|
      if @note.save
        @notes = @notable.notes
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render json: @note, status: :created, location: @note }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.json
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note = Note.find(params[:id])
    @deletedId = @note.id
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
      format.js
    end
  end
  
 private
 
 def load_notable
    resource, id = request.path.split('/')[1, 2]
    @notable = resource.singularize.classify.constantize.find(id)
  end

  def find_notable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
