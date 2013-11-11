get '/' do
  # Look in app/views/index.erb
  erb :index
end

# get "/:username" do
#   @tweets = recent_tweets(params[:username])
#   erb :user
# end

get '/:username' do
  @user = User.find_by_username(params[:username])
  if @user
    if @user.tweets_stale?
      @user.fetch_tweets!
    end
  else
    @user = User.create(username: params[:username])
    @user.fetch_tweets!
  end

  @tweets = @user.tweets.order("id DESC").limit(10)
  erb :user
end
