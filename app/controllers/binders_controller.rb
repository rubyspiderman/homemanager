class BindersController < ApplicationController
  require 'stripe'
  layout 'no_binder'
  
  before_filter :load_binder, :except => [:index, :new, :create]
  before_filter :verify_subscription, :only => [:show]
  
  # GET /binders
  # GET /binders.json
  def index
    # This is super hacky. Needs to be fixed when we do an API. This is only going to work for HTML requests.
    @binders = current_user.binders.where(:active => true)
    @subscriptions = Hash.new
    @binders.each do |b|
      if b.subscription.plan_id != 'free'
        @subscriptions[b.id] = Stripe::Customer.retrieve(b.subscription.customer_id).subscription
      end
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @binders }
    end
  end

  # GET /binders/1
  # GET /binders/1.json
  def show
    @binder = Binder.find(params[:id])
    
    authorize! :read, @binder
    
    # set this binder into the session for quick access
    session[:binder_id] = params[:id]
    
    respond_to do |format|
      format.html { render layout: 'binder' } # show.html.erb
      format.json { render json: @binder }
    end
  end

  # GET /binders/new
  # GET /binders/new.json
  def new
    @binder = Binder.new(created_by: current_user.id, primary: current_user.binders.count == 0)
    @binder.build_property
    @binder.property.property_type_id = PropertyType.where(:name => 'Single Family').first.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @binder }
    end
  end

  # GET /binders/1/edit
  def edit
    @binder = Binder.find(params[:id])
    
    authorize! :write, @binder
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @binder }
    end
  end

  # POST /binders
  # POST /binders.json
  def create
    @binder = Binder.new(params[:binder])
    
    respond_to do |format|
      if @binder.save
        # add the binder to the user's list
        current_user.binders << @binder
        
        # set the subscription level for the binder to free
        subscription = Subscription.new(binder_id: @binder.id, plan_id: 'free')
        subscription.save
        
        # make the current user the owner of the binder
        current_user.add_role :owner, @binder

        format.html { redirect_to @binder, notice: 'Binder was successfully created.' }
        format.json { render json: @binder, status: :created, location: @binder }
      else
        format.html { render action: "new" }
        format.json { render json: @binder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /binders/1
  # PUT /binders/1.json
  def update
    @binder = Binder.find(params[:id])
    
    authorize! :write, @binder

    respond_to do |format|
      if @binder.update_attributes(params[:binder])
        format.html { redirect_to @binder, notice: 'Binder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action:"edit" }
        format.json { render json: @binder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /binders/1
  # DELETE /binders/1.json
  def destroy
    @binder = Binder.find(params[:id])
    
    authorize! :destroy, @binder
   
    @binder.toggle(:active)
      
    respond_to do |format|
      format.html { redirect_to binders_url }
      format.json { head :no_content }
    end
  end
  
end
