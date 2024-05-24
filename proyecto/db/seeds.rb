users = [
  { username: 'jondoe', password: 'abc'},
  { username: 'janedoe', password: 'abcd'},
  { username: 'babydoe', password: 'abcde'},
]

users.each do |u|
  User.create(u)
end

/Barra Salud=[0],Comida[1],Agua[2],Temperatura[3]/

questions = [
  { statement: 'You come across a hive of bees', typeCard: 'Medium' },
  { statement: 'You find an abandoned campfire', typeCard: 'Medium' },
  { statement: 'You find a shallow stream', typeCard: 'Medium' },
  { statement:'You find a stream' , typeCard: 'Medium' },
  { statement:'You come across an unknown plant' , typeCard:'Medium' },
  { statement:'You find a group of mushrooms' , typeCard:'Medium' },
  { statement:'You encounter a thunderstorm' , typeCard:'Hard' },
  { statement:'You meet a group of survivors' , typeCard:'Hard' },
  { statement:'You meet a wounded wolf', typeCard:'Hard' },
  { statement:'You find an abandoned backpack', typeCard:'Easy' },
  { statement:'You find a dark cave', typeCard:'Medium' },
  { statement:'You find a fruit tree', typeCard:'Medium' },
  { statement:'Its getting a little cold', typeCard:'Medium' }
]

questions.each do |t|
  Question.create(t)
end

options = [
  { question_id: 1, description: 'Try to steal some honey', effects:[-1,1,0,0]},
  { question_id: 1, description: 'Leave the hive alone', effects:[0,-1,0,0]},
  { question_id: 2, description: 'Rekindle the campfire to keep warm', effects:[0,-1,-1,3]},
  { question_id: 2, description: 'Ignore the campfire and move on', effects:[0,0,0,-1]},
  { question_id: 3, description: 'Go looking for fish', effects:[-1,2,0,-1]},
  { question_id: 3, description: 'Avoid it', effects:[0,-1,-1,0]},
  { question_id: 4, description:'Drink water from the stream' , effects:[1,1,0,0]},
  { question_id: 4, description: 'Distrust water and look for another source', effects:[0,0,-1,0]},
  { question_id: 5, description: 'Test the plant', effects:[-3,0,0,0]},
  { question_id: 5, description:'Ignore the plant' , effects:[0,0,0,0]},
  { question_id: 6, description: 'Collect and eat mushrooms', effects:[-2,1,0,0]},
  { question_id: 6, description:'Be wary of mushrooms and move on' , effects:[0,-1,0,0]},
  { question_id: 7, description:'Take shelter under a tree' , effects:[-3,0,2,-3]},
  { question_id: 7, description:'Find a safer refuge' , effects:[0,0,3,-3]},
  { question_id: 8, description:'Try to negotiate with them' , effects:[-3,-2,-1,0]},
  { question_id: 8, description:'Avoid conflict and escape' , effects:[0,0,0,-1]},
  { question_id: 9, description:'Run' , effects:[0,-1,-1,1]},
  { question_id: 9, description:'hunt the wolf' , effects:[-3,3,-2,-1]},
  { question_id: 10, description:'Check backpack for supplies' , effects:[0,2,3,1]},
  { question_id: 10, description:'Leave the backpack in its place' , effects:[0,0,0,0]},
  { question_id: 11, description:'Explore the cave in search of shelter' , effects:[1,0,0,-2]},
  { question_id: 11, description:'Avoid the cave and continue traveling' , effects:[0,-1,-1,0]},
  { question_id: 12, description:'Collect and eat the fruit' , effects:[0,2,1,0]},
  { question_id: 12, description:'Distrust the fruit and move on' , effects:[0,-1,-1,-1]},
  { question_id: 13, description:'Create a campfire on the trail' , effects:[0,-1,0,3]},
  { question_id: 13, description:'Keep looking for shelter' , effects:[0,-1,-1,-2]}
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