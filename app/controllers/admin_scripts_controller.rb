class AdminScriptsController < ApplicationController
  layout false
  
  before_filter :verify_access
  
  def update_subsciption_plan
    subscriptions = Subscription.all
    @errors = 0
    subscriptions.each do |s|
      s.plan_id = "free"
      if not s.save
        errors += 1
      end
    end
  end
  
  def upgrade_fam_friends_to_free
    subscriptions = Subscription.all
    @errors = 0
    subscriptions.each do |s|
      if s.plan_id == 'free'
        s.plan_id = 'standard'
        s.coupon_id = 'FAMFRIENDSFREE'
        s.action = 'upgrade'
        if not s.save
          errors += 1
        end
      end
    end
  end
  
private
  
  def verify_access
    raise CanCan::AccessDenied unless current_user.has_role? :admin
  end
  
end
