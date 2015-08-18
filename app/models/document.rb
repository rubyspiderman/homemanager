class Document < ActiveRecord::Base
  
  require 's3'
  
  has_many :tags, :as => :taggable, :dependent => :destroy
  has_one :seller_report_item, :as => :seller_reportable
  
  accepts_nested_attributes_for :seller_report_item
  
  before_destroy :clean_s3
  
  private 
  
  def clean_s3
    # connect to s3
    service = S3::Service.new(:access_key_id => AppConfig.aws['access_key_id'],
                              :secret_access_key => AppConfig.aws['secret_access_key'])
    # find our bucket
    bucket = service.buckets.find(AppConfig.aws['s3_bucket'])
    #find our object
    object = bucket.objects.find("#{self.key}")
    # destroy!
    object.destroy
  end

end
