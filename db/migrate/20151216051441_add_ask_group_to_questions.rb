class AddAskGroupToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :ask_group, :integer
  end
end
