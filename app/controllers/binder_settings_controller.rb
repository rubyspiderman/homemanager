class BinderSettingsController < ApplicationController
  
  def show
    binder = Binder.find(params[:binder_id])
    
      
  end
  
end
