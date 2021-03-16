class TweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    tweet = twitter_client.tweet_media(params[:data].path)

    render json: { media_url: tweet.media.first.display_url }
  end

  private

  def twitter_client
    Clients::Twitter.new
  end
end
