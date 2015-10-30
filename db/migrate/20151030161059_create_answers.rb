class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :answerer_id
      t.string :comments
      t.string :picture_url
      t.integer :answer_option_id

      t.timestamps
    end
  end
end
