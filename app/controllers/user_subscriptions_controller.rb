class UserSubscriptionsController < ApplicationController
  require 'stripe'
  layout 'account'
  
  def index
    # This is super hacky. Needs to be fixed when we do an API. This is only going to work for HTML requests.
    user = User.find(params[:id])
    @binders = user.binders.where(:active => true)
    @subscriptions = Hash.new
    @cards = Hash.new
    @binders.each do |b|
      if b.subscription.plan_id != 'free'
        customer = Stripe::Customer.retrieve(b.subscription.customer_id)
        @subscriptions[b.id] = customer.subscription
        @cards[b.id] = customer.default_card.nil? ? nil : customer.cards.retrieve(customer.default_card)
      end
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @binders }
    end
  end
end
