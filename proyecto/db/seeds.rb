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
  { statement: 'Te encuentras con una colmena de abejas', typeCard: 'Default' },
  { statement: 'Te encuentras una fogata abandonada', typeCard: 'Default' },
  { statement: 'Te encuentras un riachuelo poco profundo', typeCard: 'Default' }
]

questions.each do |t|
  Question.create(t)
end

options = [
  { question_id: 1, description: 'Intentar robar algo de miel',effects:[-1,1,0,0]},
  { question_id: 1, description: 'Dejar la colmena en paz',effects:[0,-1,0,0]},
  { question_id: 2, description: 'Reavivar la fogata para calentarse',effects:[0,-1,-1,3]},
  { question_id: 2, description: 'Ignorar la fogata y seguir adelante',effects:[0,0,0,-1]},
  { question_id: 3, description: 'Meterse a buscar peces',effects:[-1,2,0,-1]},
  { question_id: 3, description: 'Evitarlo', effects:[0,-1,-1,0]}
]

options.each do |u|
  Option.create(u)
end
