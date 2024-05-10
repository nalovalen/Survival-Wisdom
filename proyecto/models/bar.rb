class Bar < ActiveRecord::Base
    has_many :test
    has_many :option

    #constructor (valor por defecto es 10 si no se pasa un parámetro)
    def initialize(value = 10)
        @value = value
    end

    #aplica el efecto damage a la barra de salud:
    def apply_damage(damage)
      self.value += damage
      self.save
    end

    #v2:
    #esta me asegura que cuando resto no me pase de 0 y la barra sea negativa
    def apply_damageV2(damage)
        self.value = [self.value - damage, 0].max
        self.save
    end

    #retorna el valor de la barra [0..10]
    def value
        @value
    end
end