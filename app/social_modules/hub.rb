require "facebook_module.rb"

require "pp"

instance = FacebookModule.new
data = instance.get()
#pp data["data"][0]

instance.create(data["data"][0])