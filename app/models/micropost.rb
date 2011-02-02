# == Schema Information
# Schema version: 20110131003328
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  content    :text
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  attr_accessible :title, :content

  belongs_to :user

  validates :title, :presence => true, :length => { :maximum => 140 }
  validates :content, :presence => true
  validates :user_id, :presence => true

  default_scope :order => 'microposts.created_at DESC'
end
