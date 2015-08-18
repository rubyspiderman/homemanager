class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  layout Proc.new { |controller| controller.devise_controller? ? 'account' : 'application' }

  #before_filter :authenticate_user!
  
  rescue_from CanCan::AccessDenied, :with => :unauthorized
  
  helper_method :working_user, :working_binder, :available_countries
  
  def working_user
    if params[:utoken]
      # this will eventually be a user token for use in the API
    else
      @working_user = current_user
    end
  end
  
  def working_binder
    if session[:binder_id]
        @working_binder ||= Binder.find(session[:binder_id])
    else
      if params[:binder_id]
        @working_binder ||= Binder.find(params[:binder_id])
      else
        @working_binder = nil
      end
    end
  end
  
  def user_ability
    if current_user
      ability = Ability.new(current_user)
    end
  end
  
  def available_countries
    Carmen::Country.all.select{|c| %w{US}.include?(c.code)}
  end
  
protected

  def unauthorized
    respond_to do |format|
      format.html { render :file => "public/401.html", :status => :unauthorized , :layout => false}
      format.json { render json: nil, :status => :unauthorized }
    end
  end
  
  def load_binder
    @binder = params[:controller] == 'binders' ?
      Binder.includes(:subscription).find(params[:id]) :
      Binder.includes(:subscription).find(params[:binder_id])
  end
  
  def verify_subscription
    if @binder.nil?
      load_binder
    end
    
    if @binder.subscription.plan_id != 'free' && @binder.subscription.payment_status == 'failed'
      respond_to do |format|
        if can? :subscribe, @binder
          format.html { redirect_to @binder.subscription }
          format.json { render json: 'The subscription for the binder has not been paid.', status: :unprocessable_entity }
        else
          format.html { render :file => "public/subscription_failed.html", :status => :unauthorized, :layout => false}
          format.json { render json: 'The subscription for the binder has not been paid.', status: :unprocessable_entity }
        end
      end
    end
    
    return false
  end
  
end
