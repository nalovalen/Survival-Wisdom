class CreateQuestionsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :statement
      t.string :typeCard
    end
  end
end

