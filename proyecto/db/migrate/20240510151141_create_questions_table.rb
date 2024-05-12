class CreateQuestionsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :statement
      t.string :typeCard
      
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end

