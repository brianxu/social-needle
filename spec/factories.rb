# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Michael Hartl"
  user.email                 "user@gmail.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :post do |post|
  post.title "fooTitle"
  post.content "fooContent"
  post.association :user
end

Factory.define :comment do |comment|
  comment.content "fooComment"
  comment.association :user
  comment.association :post
end
