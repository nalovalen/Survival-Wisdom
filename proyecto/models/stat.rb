class Stat < ActiveRecord::Base
    has_many :tests
    belongs_to :user
end