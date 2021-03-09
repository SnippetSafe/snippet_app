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
        config.consumer_key        = "0bEb97Ev9jfb0SdZAc3bnvuzq"
        config.consumer_secret     = "x5cpKgPzcdhXXHPKDKOuo5JAIOhMDr3Y22SZiYwHrHvV9dUzuW"
        config.access_token        = "1354061940260294656-OA3CosQ2hUd90llhxLubtdNASYfgaW"
        config.access_token_secret = "k8MZ8tCtvIJQs56FNjRzkbDHzY7BIkoOh5IVqAK4fnt4A"
      end
    end

  end
end