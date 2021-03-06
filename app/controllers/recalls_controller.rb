class RecallsController < ApplicationController
  
  def index
    @appliance = Appliance.find(params[:appliance_id])
    
    binder = Binder.includes(:subscription).find(@appliance.binder_id)
    if binder.subscription.plan_id == 'free'
      raise 'Permission Denied'
    end
    
    @page = params[:page].nil? ? 1 : params[:page].to_i
    @recallCheck = RecallCheck.new(@appliance)
    @recallCheck.run(nil, @page)
  end
  
end
