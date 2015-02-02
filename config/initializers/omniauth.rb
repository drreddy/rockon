OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  	provider :facebook, FACEBOOK_CONFIG['app_id'], FACEBOOK_CONFIG['secret'],
  			:scope => 'basic_info, public_profile, user_about_me, user_activities, user_friends, user_likes,read_stream,publish_stream,share_item', :display => 'popup'
end