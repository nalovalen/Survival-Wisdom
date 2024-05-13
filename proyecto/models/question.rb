class Question < ActiveRecord::Base
    has_many :options
    has_many :answers
    belongs_to :test
end