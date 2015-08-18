class HomeController < ApplicationController
  layout 'landing'
  
  skip_before_filter :authenticate_user!
  
  def index
    if current_user
      primary_binder = current_user.binders.where(:primary => true)[0]
      if primary_binder
        redirect_to primary_binder
      else
        redirect_to user_binders_path(current_user)
      end
    end
  end
  
  def help
    
  end
  
  def about
    
  end
  
end
