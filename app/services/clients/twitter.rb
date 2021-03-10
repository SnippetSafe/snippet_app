require 'twitter'

module Clients
  class Twitter

    def tweet(body)
      client.update(body)
    end

    def tweet_media(filepath)
      client.update_with_media('', File.new(filepath))
    end

    private
  
    def client
      @client ||= ::Twitter::REST::Client.new do |config|
        credentials = Rails.application.credentials.dig(Rails.env.to_sym, :twitter)

        config.consumer_key = credentials.dig(:consumer_key)
        config.consumer_secret = credentials.dig(:consumer_secret)
        config.access_token = credentials.dig(:access_token)
        config.access_token_secret = credentials.dig(:access_token_secret)
      end
    end

  end
end