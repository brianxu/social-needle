# == Schema Information
# Schema version: 20110203221555
#
# Table name: comments
#
#  id           :integer         not null, primary key
#  user_id      :integer
#  post_id :integer
#  content      :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Comment < ActiveRecord::Base
  attr_accessible :content


  belongs_to :user
  belongs_to :post

  validates :user_id, :presence => true
  validates :post_id, :presence => true
  validates :content, :presence => true

  default_scope :order => 'comments.created_at DESC'
end
