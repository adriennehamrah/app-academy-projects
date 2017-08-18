# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create([{username: 'rebekahliu'}, {username: 'adrianramos'}, {username: 'adriennelin'}])
Poll.create([{user_id: 1, title: 'Favorites'}, {user_id: 2, title: 'Politics'}])
Question.create([{poll_id: 1, text: 'What is your fav color?'},
  {poll_id: 1, text: 'What is your fav animal?'},
  {poll_id: 2, text: 'What is your political party?'},
  {poll_id: 2, text: 'Do you like Trump?'}])
AnswerChoice.create([{question_id: 1, text: 'A. Red'},
  {question_id: 1, text: 'B. Blue'},
  {question_id: 1, text: 'C. Green'},
  {question_id: 1, text: 'D. Orange'},
  {question_id: 2, text: 'A. Dog'},
  {question_id: 2, text: 'B. Cat'},
  {question_id: 2, text: 'C. Panda'},
  {question_id: 2, text: 'D. Chinchilla'},
  {question_id: 3, text: 'A. Republican'},
  {question_id: 3, text: 'B. Democrat'},
  {question_id: 3, text: 'C. Liberterian'},
  {question_id: 3, text: 'D. Green'},
  {question_id: 4, text: 'A. No'},
  {question_id: 4, text: 'B. Hellll no'},
  {question_id: 4, text: 'C. I guess'},
  {question_id: 4, text: 'D. Never'}])
Response.create([{user_id: 1, answer_choice_id: 2},
  {user_id: 1, answer_choice_id: 7},
  {user_id: 1, answer_choice_id: 10},
  {user_id: 1, answer_choice_id: 14},
  {user_id: 2, answer_choice_id: 3},
  {user_id: 2, answer_choice_id: 5},
  {user_id: 2, answer_choice_id: 9},
  {user_id: 2, answer_choice_id: 13},
  {user_id: 3, answer_choice_id: 4},
  {user_id: 3, answer_choice_id: 8},
  {user_id: 3, answer_choice_id: 11},
  {user_id: 3, answer_choice_id: 13}])
