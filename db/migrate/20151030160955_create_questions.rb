class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :creator_id
      t.string :question_text

      t.timestamps
    end
  end
end
