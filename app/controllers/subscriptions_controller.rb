class SubscriptionsController < ApplicationController
  require 'stripe'
  layout 'account'
  
  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = Subscription.where(:binder_id => params[:binder_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subscriptions }
    end
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    @subscription = Subscription.find(params[:id])
    @binder = Binder.find(@subscription.binder_id)
   
    authorize! :subscribe, Binder.find(@subscription.binder_id)
    
    @standardPlan = Stripe::Plan.retrieve('standard')
    @total = 0.0
    
    if not @subscription.customer_id.nil?
      @customer = Stripe::Customer.retrieve(@subscription.customer_id)
      @card = @customer.default_card.nil? ? nil : @customer.cards.retrieve(@customer.default_card)
      @subtotal = @customer.subscription.plan.amount
      @discount = 0.0
      
      if not @customer.discount.nil?
        @discount = @customer.discount.coupon.amount_off.nil? ?
          @subtotal * (@customer.discount.coupon.percent_off / 100.00) 
          : @customer.discount.coupon.amount_off
      end 
      @total = @subtotal - @discount
    end
   
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/new
  # GET /subscriptions/new.json
  def new
    @subscription = Subscription.new(binder_id: params[:binder_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/1/edit
  def edit
    @subscription = Subscription.find(params[:id])
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(params[:subscription])

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to Binder.find(@subscription.binder_id), notice: 'Subscription was successfully created.' }
        format.json { render json: @subscription, status: :created, location: @subscription }
      else
        format.html { render action: "new" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subscriptions/1
  # PUT /subscriptions/1.json
  def update
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      begin
        if @subscription.update_attributes(params[:subscription])
          format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
          format.json { render json: @subscription }
        else
          format.html { render action: "edit" }
          format.json { render json: "coupon is bad", status: :unprocessable_entity }
        end
      rescue Stripe::CardError => e
        # Since it's a decline, Stripe::CardError will be caught
        body = e.json_body
        err  = body[:error]
        
        format.html { render action: "edit" }
        format.json { render json: "#{err[:message].titleize}", status: :unprocessable_entity }
      rescue Stripe::InvalidRequestError => e
        # Since it's a decline, Stripe::CardError will be caught
        body = e.json_body
        err  = body[:error]
        
        format.html { render action: "edit" }
        format.json { render json: "#{err[:message].titleize}", status: :unprocessable_entity }
      rescue Stripe::AuthenticationError => e
        # Authentication with Stripe's API failed
        # (maybe you changed API keys recently)
        format.html { render action: "edit" }
        format.json { render json: "We're having trouble processing your request. Try again later.", status: :unprocessable_entity }
      rescue Stripe::APIConnectionError => e
        # Network communication with Stripe failed
        format.html { render action: "edit" }
        format.json { render json: "We're having trouble processing your request. Try again later.", status: :unprocessable_entity }
      rescue Stripe::StripeError => e
        # Display a very generic error to the user, and maybe send
        # yourself an email
        format.html { render action: "edit" }
        format.json { render json: "We're having trouble processing your request. Try again later.", status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to subscriptions_url }
      format.json { head :no_content }
    end
  end
  
end
