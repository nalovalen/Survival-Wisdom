class User < ActiveRecord::Base
    # Otros métodos y definiciones de la clase...
    has_many :stats
    has_many :tests
    has_many :answers
    has_many :skills


    validates :username, presence: true, uniqueness: true
    validates :password, presence: true

    def self.authenticate(username, password)
      user = find_by(username: username)
      if user && user.password == password
        return user # Credenciales válidas, devuelve el usuario
      else
        return nil # Credenciales inválidas, devuelve nil
      end
    end

    def name
      self[:username]
    end

  end
