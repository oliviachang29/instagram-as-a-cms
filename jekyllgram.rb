# Based off benbarber's https://github.com/benbarber/jekyll-instagram/blob/master/_plugins/jekyllgram.rb
# Put this in _plugins/jekyllgram.rb

require 'jekyll'
require 'net/http'
require 'json'

module Jekyll
  
  class Jekyllgram < Liquid::Block
    include Liquid::StandardFilters

    def initialize(tag, params, token)
      @limit = params.to_i
      # ------------------------------------------- #
      # REPLACE YOURAPPNAME WITH YOUR OWN APP NAME #
      # ------------------------------------------- #
      @access_token_heroku = 'https://YOURAPPNAME.herokuapp.com/token.json' # Use the token.json version
      @api_url = 'https://graph.instagram.com/me/media?fields=caption,id,media_type,media_url,permalink,thumbnail_url,timestamp,username&access_token='
      super
    end

    def render(context)
    	get_access_token()
      context.registers[:jekyllgram] ||= Hash.new(0)
      content = generate(context, recent_photos)

      content
    end

    private

    def generate(context, photos)
      result = []

      context.stack do
        photos.each_with_index do |photo, index|
          context['photo'] = photo
          result << @body.render(context)

          break if index + 1 == @limit
        end
      end

      result
    end

    def get_access_token
    	access_token_response = Net::HTTP.get_response(URI.parse(@access_token_heroku))
    	return [] unless access_token_response.is_a?(Net::HTTPSuccess)
    	access_token_response = JSON.parse(access_token_response.body)
    	@access_token = access_token_response['token']
    end

    def recent_photos
      insta_response = Net::HTTP.get_response(URI.parse(@api_url + @access_token))
      if !(insta_response.is_a?(Net::HTTPSuccess))
      	warn "Instagram fetch failed. API limit likely reached."
      end
      return [] unless insta_response.is_a?(Net::HTTPSuccess)
      insta_response = JSON.parse(insta_response.body)
      insta_response['data']
    end
  end
end

Liquid::Template.register_tag('jekyllgram', Jekyll::Jekyllgram)