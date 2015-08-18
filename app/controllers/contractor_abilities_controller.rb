class ContractorAbilitiesController < ApplicationController
  # GET /contractor_abilities
  # GET /contractor_abilities.json
  def index
    @contractor_abilities = ContractorAbility.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contractor_abilities }
    end
  end

  # GET /contractor_abilities/1
  # GET /contractor_abilities/1.json
  def show
    @contractor_ability = ContractorAbility.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contractor_ability }
    end
  end

  # GET /contractor_abilities/new
  # GET /contractor_abilities/new.json
  def new
    @contractor_ability = ContractorAbility.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contractor_ability }
    end
  end

  # GET /contractor_abilities/1/edit
  def edit
    @contractor_ability = ContractorAbility.find(params[:id])
  end

  # POST /contractor_abilities
  # POST /contractor_abilities.json
  def create
    @contractor_ability = ContractorAbility.new(params[:contractor_ability])

    respond_to do |format|
      if @contractor_ability.save
        format.html { redirect_to @contractor_ability, notice: 'Contractor ability was successfully created.' }
        format.json { render json: @contractor_ability, status: :created, location: @contractor_ability }
      else
        format.html { render action: "new" }
        format.json { render json: @contractor_ability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contractor_abilities/1
  # PUT /contractor_abilities/1.json
  def update
    @contractor_ability = ContractorAbility.find(params[:id])

    respond_to do |format|
      if @contractor_ability.update_attributes(params[:contractor_ability])
        format.html { redirect_to @contractor_ability, notice: 'Contractor ability was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contractor_ability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contractor_abilities/1
  # DELETE /contractor_abilities/1.json
  def destroy
    @contractor_ability = ContractorAbility.find(params[:id])
    @contractor_ability.destroy

    respond_to do |format|
      format.html { redirect_to contractor_abilities_url }
      format.json { head :no_content }
    end
  end
end
