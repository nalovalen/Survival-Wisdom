class Question < ActiveRecord::Base
    has_many :options
    has_many :answers
    belongs_to :test

    #constructor:
    def initialize(attributes = {})
      super
      @statement = attributes[:statement]
      @type_card = attributes[:typeCard]
    end

    #getter del statement:
    def statement
      @statement
    end

    #getter del id:
    def id
      self[:id]
    end

    #getter del tipo de carta:
    def type_card
      @type_card
    end
end