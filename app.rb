require 'sinatra'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'google/apis/calendar_v3'
require 'google-id-token'
require 'dotenv'

configure do
  Dotenv.load

  Google::Apis::ClientOptions.default.application_name = 'Ruby client samples'
  Google::Apis::ClientOptions.default.application_version = '0.9'
  Google::Apis::RequestOptions.default.retries = 3

  enable :sessions
  set :show_exceptions, false

  set :client_id, Google::Auth::ClientId.new(
    ENV['GOOGLE_CLIENT_ID'],
    ENV['GOOGLE_CLIENT_SECRET'] 
  )

  set :token_store, Google::Auth::Stores::FileTokenStore.new(file: ENV['CREDENTIALS_PATH'])
end

helpers do
  # Returns credentials authorized for the requested scopes. If no credentials are available,
  # redirects the user to authorize access.
  def credentials_for(scope)
    authorizer = Google::Auth::WebUserAuthorizer.new(settings.client_id, scope, settings.token_store)

    user_id = ENV["GCAL_EMAIL"]

    credentials = authorizer.get_credentials(user_id, request)

    if credentials.nil?
      redirect authorizer.get_authorization_url(login_hint: user_id, request: request)
    end
    credentials
  end

end

get('/') do
  @client_id = settings.client_id.id

  service = Google::Apis::CalendarV3::CalendarService.new
  service.authorization = credentials_for(Google::Apis::CalendarV3::AUTH_CALENDAR)

  calendar_id = ENV["GCAL_EMAIL"] 
  #Note: many users have many calendars, so if you want a different one, just change this calendar_id

  @result = service.list_events(calendar_id,
                                max_results: 10,
                                single_events: true,
                                order_by: 'startTime',
                                time_min: Time.now.iso8601
                               )

  erb :home
end


# Callback for authorization requests. This saves the autorization code and
# redirects back to the URL that originally requested authorization. The code is
# redeemed on the next request.
#
# Important: While the deferred approach is generally easier, it doesn't play well
# with developer mode and sinatra's default cookie-based session implementation. Changes to the
# session state are lost if the page doesn't render due to error, which can lead to further
# errors indicating the code has already been redeemed.
#
# Disabling show_exceptions or using a different session provider (E.g. Rack::Session::Memcache)
# avoids the issue.
get('/oauth2callback') do
  target_url = Google::Auth::WebUserAuthorizer.handle_auth_callback_deferred(request)
  redirect target_url
end
