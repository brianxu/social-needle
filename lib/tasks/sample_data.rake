require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.create!(:name => "Example User",
                 :email => "example@railstutorial.org",
                 :password => "foobar",
                 :password_confirmation => "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end

    User.all(:limit => 6).each do |user|
      50.times do
        user.posts.create!(:title => Faker::Lorem.sentence(2),
                           :content => Faker::Lorem.sentence(5))
      end
    end

    User.all(:limit => 6).each do |user|
      10.times do
        user.comments.create!(:content => Faker::Lorem.sentence(8),
                              :post_id => 1)
      end
    end
                              
  end
end

