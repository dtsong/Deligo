class AddOpenToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :open, :boolean
  end
end
