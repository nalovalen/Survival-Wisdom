class User < ActiveRecord::Base
    # Otros métodos y definiciones de la clase...

    def self.authenticate(username, password)
      user = find_by(username: username)
      if user && user.password == password
        return user # Credenciales válidas, devuelve el usuario
      else
        return nil # Credenciales inválidas, devuelve nil
      end
    end

  end
