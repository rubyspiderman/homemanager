class BaseBinderController < ApplicationController
  
  private
  
  def verify_subscription!
    binder_id = controller_name == 'binders' ? Subscription.find_by_binder_id(params[:id]) : Subscription.find(params[:binder_id])
    subscription = Subscription.find_by_binder_id(binder_id)
 
    if subscription.nil?
      # no subscription means free
      @deliquent = false
    else
      # check if the user is deliquent
      c = Stripe::Customer.retrieve(subscription.customer_id)
      @deliquent = c.delinquent
    end
    
    if @deliquent
      respond_to do |format|
        format.html { render layout: 'binder' }
        format.json { render json: 'The subscription for the binder has not been paid.', status: :unprocessable_entity }
      end
      return false
    end
  end
  
end
