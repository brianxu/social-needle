class AddTypeToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :type, :string
  end

  def self.down
    remove_column :posts
  end
end
