class TweetsController < ApplicationController
  def create
    twitter_client.tweet_media(params[:data].path)
  end

  private

  def twitter_client
    Clients::Twitter.new
  end
end
