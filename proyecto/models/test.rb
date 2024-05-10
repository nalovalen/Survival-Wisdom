class Test < ActiveRecord::Base
    belongs_to :user
    has_many :bars
    has_one :stat
    has_many :questions
end