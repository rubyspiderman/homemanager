class ConstructionStylesController < ApplicationController
  # GET /construction_styles
  # GET /construction_styles.json
  def index
    @construction_styles = ConstructionStyle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @construction_styles }
    end
  end

  # GET /construction_styles/1
  # GET /construction_styles/1.json
  def show
    @construction_style = ConstructionStyle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @construction_style }
    end
  end

  # GET /construction_styles/new
  # GET /construction_styles/new.json
  def new
    @construction_style = ConstructionStyle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @construction_style }
    end
  end

  # GET /construction_styles/1/edit
  def edit
    @construction_style = ConstructionStyle.find(params[:id])
  end

  # POST /construction_styles
  # POST /construction_styles.json
  def create
    @construction_style = ConstructionStyle.new(params[:construction_style])

    respond_to do |format|
      if @construction_style.save
        format.html { redirect_to @construction_style, notice: 'Construction style was successfully created.' }
        format.json { render json: @construction_style, status: :created, location: @construction_style }
      else
        format.html { render action: "new" }
        format.json { render json: @construction_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /construction_styles/1
  # PUT /construction_styles/1.json
  def update
    @construction_style = ConstructionStyle.find(params[:id])

    respond_to do |format|
      if @construction_style.update_attributes(params[:construction_style])
        format.html { redirect_to @construction_style, notice: 'Construction style was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @construction_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /construction_styles/1
  # DELETE /construction_styles/1.json
  def destroy
    @construction_style = ConstructionStyle.find(params[:id])
    @construction_style.destroy

    respond_to do |format|
      format.html { redirect_to construction_styles_url }
      format.json { head :no_content }
    end
  end
end
