class AddAskFriendsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :ask_friends, :boolean
  end
end
