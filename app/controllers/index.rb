get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)

  oauth_token = @access_token.params[:oauth_token]
  oauth_secret = @access_token.params[:oauth_token_secret]
  name = @access_token.params[:screen_name]

  user = User.find_or_create_by(username: name, oauth_token: oauth_token, oauth_secret: oauth_secret)
  set_current_user(user)


  # # at this point in the code is where you'll need to create your user account and store the access token

  erb :index

end

post '/tweet' do
  client = twitter_client
  client.access_token = current_user.oauth_token
  client.access_token_secret = current_user.oauth_secret
  client.update(params[:text])
  redirect '/success'
end

get '/success' do
  erb :success
end
