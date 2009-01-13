require 'net/http'
require 'digest/md5'

module Merb
  module PostsHelper
    def date date_time
       date_time.strftime("%d-%m-%Y")
    end
    
    def textile text
      RedCloth.new(text).to_html unless text.blank?
    end
    
    def comment_author name,url
      if url.blank?
        name
      else
        link_to( name,url ) unless url.blank?
      end
    end

    # Is there a Gravatar for this email? Optionally specify :rating and :timeout.
    def gravatar?(hash, options = {})
      options = { :rating => 'x', :timeout => 2 }.merge(options)
      http = Net::HTTP.new('www.gravatar.com', 80)
      http.read_timeout = options[:timeout]
      response =  http.request_head("/avatar/#{hash}?rating=#{options[:rating]}&default=http://gravatar.com/avatar")
      response.code != '302'
    rescue StandardError, Timeout::Error
      true  # Don't show "no gravatar" if the service is down or slow
    end

    def gravatar email
      email = Digest::MD5::hexdigest(email.downcase)
      if gravatar? email
        image_tag "http://www.gravatar.com/avatar/#{email}",:alt=>'users gravatar'
      else
        image_tag 'no-avatar.png',:alt=>'avatar'
      end
    end
  end
end # Merb