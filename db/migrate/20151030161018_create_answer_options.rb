class CreateAnswerOptions < ActiveRecord::Migration
  def change
    create_table :answer_options do |t|
      t.integer :question_id
      t.string :option

      t.timestamps
    end
  end
end
