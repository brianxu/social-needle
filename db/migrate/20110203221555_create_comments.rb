class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id
      t.text :content

      t.timestamps
    end
    add_index :comments, :post_id
    add_index :comments, :user_id
  end

  def self.down
    drop_table :comments
  end
end
