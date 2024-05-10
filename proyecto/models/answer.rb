class Answer < ActiveRecord::Base
    belongs_to :option
    belongs_to :user
    belongs_to :question
end