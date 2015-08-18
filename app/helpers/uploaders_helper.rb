require 'base64'
require 'openssl'
require 'digest/sha1'

module UploadersHelper
  
  def initialize_uploader(user, binder, controller)
    # Plupload/S3 initialization
    access_key_id     = AppConfig.aws['access_key_id']
    secret_access_key = AppConfig.aws['secret_access_key']
    acl               = "public-read"
    max_file_size     = "10485760"
    expired_date      ||= 10.hours.from_now.utc.iso8601
    s3_bucket         = AppConfig.aws['s3_bucket']
    
    gon.user = user
    gon.binder = binder
    gon.controller = controller
    gon.url = AppConfig.aws['bucket_url']
    gon.temporary_file_location = "<a href='http://s3.amazonaws.com/#'>http://s3.amazonaws.com/#</a>{AppConfig[:s3_bucket]}/" 
    gon.acl = acl
    gon.access_key_id = access_key_id
    gon.policy = Base64.encode64(
      "{'expiration': '#{expired_date}',
        'conditions': [
          {'bucket': '#{s3_bucket}'},
          {'acl': '#{acl}'},
          {'success_action_status': '201'},
          ['content-length-range', 0, #{max_file_size}],
          ['starts-with', '$key', ''],
          ['starts-with', '$Content-Type', ''], 
          ['starts-with', '$name', ''],
          ['starts-with', '$Filename', ''],
          ['starts-with', '$success_action_status', '']
        ]
      }").gsub(/\n|\r/, '')
   
    gon.signature = Base64.encode64(
      OpenSSL::HMAC.digest(
        OpenSSL::Digest::Digest.new('sha1'),
        secret_access_key, gon.policy
      )
    ).gsub("\n","")
  end  
  
end
