class AddAllowCommentsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :allow_comments, :boolean
  end
end
