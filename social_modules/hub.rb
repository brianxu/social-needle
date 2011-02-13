require "facebook_module.rb"

require "pp"

module HUB
  def HUB.start
    instance = FacebookModule.new
    data = instance.get()

    data.each do |entry|
      print_post(entry)
      save_to_db(entry)
    end
  end
  
  def HUB.save_to_db(entry)
    entry[:post].save!
    if not entry[:comments].nil?
      entry[:comments].each do |comment|
        comment.post_id = entry[:post].id
        comment.save!
      end
    end
  end
  
  def HUB.print_post(post)
    print "#{post[:post].content}\n"
    if not post[:comments].nil?
      post[:comments].each do |comment|
        print "\t#{comment.content} #{comment.post_id}\n"
      end
    end
  end
end



########################## MAIN ##############################

HUB.start

 

