class AddAskPublicToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :ask_public, :boolean
  end
end
