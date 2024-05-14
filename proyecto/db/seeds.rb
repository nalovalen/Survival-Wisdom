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
  { question_id: 1, description: 'Intentar robar algo de miel', effects:[-1,1,0,0]},
  { question_id: 1, description: 'Dejar la colmena en paz', effects:[0,-1,0,0]},
  { question_id: 2, description: 'Reavivar la fogata para calentarse', effects:[0,-1,-1,3]},
  { question_id: 2, description: 'Ignorar la fogata y seguir adelante', effects:[0,0,0,-1]},
  { question_id: 3, description: 'Meterse a buscar peces', effects:[-1,2,0,-1]},
  { question_id: 3, description: 'Evitarlo', effects:[0,-1,-1,0]}
]

options.each do |u|
  Option.create(u)
end

skills = [
  {name: 'fire', description: 'It is essential for survival in the wild. Provides heat to keep warm, helps cook food, purify water and scare away dangerous animals. Additionally, fire can be a source of light and morale in emergency situations.' , dificulty:'Easy' },
  {name: 'water', description: 'It is essential for life and survival. Without water, the human body cannot function properly. In survival situations, it is crucial to find sources of clean water or learn how to purify water to make it safe to drink.' , dificulty:'Medium'},
  {name: 'food', description: 'Provides the energy needed to stay active and healthy. In survival situations, it is important to know how to identify and gather edible wild foods, as well as hunting and fishing techniques. It is also helpful to carry emergency food with you, such as energy bars or dehydrated foods.' , dificulty:'Medium'},
  {name: 'shelter', description: 'Protects from extreme weather and provides a safe place to rest. In survival situations, shelter can be as simple as a makeshift shelter made of branches and leaves, or as complex as a sturdy tent.' , dificulty:'Medium'},
  {name: 'medicine', description: 'In survival settings, medical care may be limited or nonexistent. Therefore, it is important to have basic first aid knowledge and carry basic medical supplies, such as bandages, disinfectants, and pain medications.' , dificulty:'Hard'}
]

skills.each do |t|
  Skill.create(t)
end

guides = [
  {title: 'fire' , rute_content:'/assets/contets/guideFire' , skill_id: 1},
  {title: 'water' , rute_content:'/assets/contets/guideWater' , skill_id: 2},
  {title:'food' , rute_content:'/assets/contets/guideFood' , skill_id: 3},
  {title: 'shelter', rute_content:'/assets/contets/guideShelter' , skill_id: 4},
  {title: 'medicine', rute_content:'/assets/contets/guideMedicine' , skill_id: 5}
]

guides.each do |u|
  Guide.create(u)
end

bars = [
  {name_bar: 'temperature', value: 10},
  {name_bar: 'water', value: 10},
  {name_bar: 'hunger', value: 10},
  {name_bar: 'health', value: 10}
]

bars.each do |u|
  Bar.create(u)
end