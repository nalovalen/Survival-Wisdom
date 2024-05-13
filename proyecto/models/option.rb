class Option < ActiveRecord::Base
    has_many :bars
    has_one :answer
    belongs_to :question
end