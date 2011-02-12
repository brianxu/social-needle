require "social_module.rb"
require 'rubygems'
require 'json'
require 'net/https'

require "../config/environment.rb"

class FacebookModule < SocialModule
public
  def post(posts)
    print "FacebookModule"
  end
  
  def get()
    access_token = "179195245434118|2.T37qqb_WzdRf8l9L5VvPBw__.3600.1297407600-574632066|T5K7Zbi3tbeX4k_G9-2bCgTdYKo"

    base_url = "https://graph.facebook.com/"
    object_id = "190432160986343"   # social needle page id
    connection_name = "feed"

    url = URI.parse(URI.encode("#{base_url}#{object_id}/#{connection_name}?access_token=#{access_token}"))
    req = Net::HTTP::Get.new(url.path)
    http_session = Net::HTTP.new(url.host, url.port)
    http_session.use_ssl = true
    res = http_session.start { |http| 
     http.request(req)
    }

    data = res.body

    # we convert the returned JSON data to native Ruby
    # data structure - a hash
    result = JSON.parse(data)
    

    # # if the hash has 'Error' as a key, we raise an error
    #    if result.has_key? 'Error'
    #    raise "web service error"
    #    end
    # 
    #    result["data"].each do  |data|
    #     facebook_post = Facebookpost.find_by_post_id(data["id"])
    #     if facebook_post.nil?
    #       create(data)
    #     end
    #    end
  end
  
#private
  def create(data)
    facebook_admin = User.find_by_name("facebook")
    if facebook_admin.nil?
      raise "facebook admin does not exist!\n"
    end
    facebook_post = facebook_admin.facebook_posts.build(:title => data["message"],
                                                     :content => data["message"])
    #facebook_post.created_at = data["created_time"]
    #facebook_post.updated_at = data["updated_time"]
    if not facebook_post.save
      raise "cannot create facebook post\n"
    end
  end

end
