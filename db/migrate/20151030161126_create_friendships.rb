class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :user_id1
      t.integer :user_id2

      t.timestamps
    end
  end
end
