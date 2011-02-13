require "social_module.rb"
require 'rubygems'
require 'json'
require 'net/https'

require "../config/environment.rb"

require 'pp'

class FacebookModule < SocialModule
public
  def post(posts)
    print "FacebookModule"
  end
  
  def get()
    access_token = "179195245434118|2.9zPYbg2bUZySdhakqxaXQg__.3600.1297551600-574632066|_lw45x6rANPZH-g-nvuUPKpqFd8"

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

    # we convert the returned JSON data to native Ruby
    # data structure - a hash
    result = JSON.parse(res.body)
    #pp result["data"]

    # if the hash has 'Error' as a key, we raise an error
    if result.has_key? 'Error'
      raise "web service error"
    end
    
    posts = Array.new
    result["data"].each do |data|
      if data.has_key?("comments")
        comments = Array.new
        facebook_post = create_post(data)
        data["comments"]["data"].each do |comment_data|
          facebook_comment = create_comment(comment_data)
          comments.push(facebook_comment)
        end
        posts.push({:post => facebook_post,
                    :comments => comments})
      else
        #print "#{data["message"]} #{data["from"]["name"]} #{data["created_time"]} #{data["updated_time"]}\n"
        facebook_post = create_post(data)
        posts.push({:post => facebook_post,
                    :comments => nil})
      end
    end
    
    return posts
  end
  
private
  def create_post(data)
    facebook_admin = get_facebook_admin
    title = data["message"]
    content = "@\"#{data["from"]["name"]}\":#{title}"
    facebook_post = facebook_admin.facebook_posts.build(:title => title,
                                                        :content => content)
    facebook_post.created_at = data["created_time"]
    facebook_post.updated_at = data["updated_time"]
    
    return facebook_post
  end
  
  def create_comment(data)
    facebook_admin = get_facebook_admin
    content = "@\"#{data["from"]["name"]}\": #{data["message"]}"
    facebook_comment = facebook_admin.facebook_comments.build(:content => content)
    facebook_comment.created_at = data["created_time"]
    facebook_comment.updated_at = data["created_time"]
    
    return facebook_comment
  end
  
  def get_facebook_admin()
    facebook_admin = User.find_by_name("facebook")
    if facebook_admin.nil?
      raise "facebook admin does not exist!\n"
    end
    
    return facebook_admin
  end

end
