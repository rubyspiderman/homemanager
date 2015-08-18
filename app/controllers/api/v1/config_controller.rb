require 'base64'
require 'openssl'
require 'digest/sha1'

class Api::V1::ConfigController < Api::V1::ApiController

  skip_before_filter :verify_api_key
  skip_before_filter :verify_jwt_token
  before_filter :verify_homebinder_api_key

  def index
    render :status => 200, :json => {
      :s3 => {
        :url => AppConfig.aws['bucket_url'],
        :bucket => AppConfig.aws['s3_bucket'],
        :access_key_id => AppConfig.aws['access_key_id'],
        :secret_access_key => AppConfig.aws['secret_access_key'],
        :acl => 'public-read',
        :policy  => get_s3_policy,
        :signature => get_s3_signature
      },
      :stripe => {
        :public_key => Rails.configuration.stripe[:publishable_key]
      }
    }
  end
  
  def verify_homebinder_api_key
    api_key = request.headers['HB-APIKey']
    if (api_key.nil?)
      render :status => 403, :json => {:message => "Api key missing"}
      return
    end
    
    # TODO Api Key lookup. This must be a homebinder key
    api_key_object = ApiKey.find_by_key(api_key)
    if api_key_object.nil? || api_key_object.company_name != 'HomeBinder.com'
      render :status => 403, :json => {:message => 'Invalid API Key'}
      return
    end
  end
  
  def get_s3_policy
    access_key_id     = AppConfig.aws['access_key_id']
    secret_access_key = AppConfig.aws['secret_access_key']
    acl               = "public-read"
    max_file_size     = "10485760"
    expired_date      ||= 10.hours.from_now.utc.iso8601
    s3_bucket         = AppConfig.aws['s3_bucket']
    
    return Base64.encode64(
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
  end
  
  def get_s3_signature
    secret_access_key = AppConfig.aws['secret_access_key']
    
    return Base64.encode64(
      OpenSSL::HMAC.digest(
        OpenSSL::Digest::Digest.new('sha1'),
          secret_access_key, get_s3_policy
      )
    ).gsub("\n","")
  end

end