/users = [
  { names: 'Jon Doe', username: 'jondoe', email: 'jon@doe.com', password: 'abc'},
  { names: 'Jane Doe', username: 'janedoe', email: 'jane@doe.com', password: 'abcd'},
  { names: 'Baby Doe', username: 'babydoe', email: 'baby@doe.com', password: 'abcde'},
]

users.each do |u|
  User.create(u)
end
/
/Barra Salud=[0],Comida[1],Agua[2],Temperatura[3]/

questions = [
  { statement: 'Te encuentras con una colmena de abejas', tipo: 'Default' },
  { statement: 'Te encuentras una fogata abandonada', tipo: 'Default' },
  { statement: 'Te encuentras un riachuelo poco profundo', tipo: 'Default' }
]

questions.each do |t|
  Question.create(t)
end

options = [
  { question_id: 1, description: 'Intentar robar algo de miel',efectos:[-1,1,0,0]},
  { question_id: 1, description: 'Dejar la colmena en paz',efectos:[0,-1,0,0]},
  { question_id: 2, description: 'Reavivar la fogata para calentarse',efectos:[0,-1,-1,3]},
  { question_id: 2, description: 'Ignorar la fogata y seguir adelante',efectos:[0,0,0,-1]},
  { question_id: 3, description: 'Meterse a buscar peces',efectos:[-1,2,0,-1]},
  { question_id: 3, description: 'Evitarlo', efectos:[0,-1,-1,0]}
]

options.each do |u|
  Option.create(u)
end
