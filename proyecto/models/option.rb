class Option < ActiveRecord::Base
    has_many :bars
    has_one :answer
    belongs_to :question

    #constructor
    def initialize(attributes = {})
      super
      @description = attributes[:description]
      @effects = attributes[:effects]
    end

    #getter de descricpción
    def description
      @description
    end

    #getter de los efectos
    def effects
      @effects
    end
end