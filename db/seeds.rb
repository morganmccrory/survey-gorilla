require 'faker'

poop = User.create(name: 'chase', birthday: Faker::Date.birthday,
              password: 'poop' , gender: ["male", "female"].sample,
              email: 'poop@poop.com')

3.times do
  User.create(name: Faker::Name.name, birthday: Faker::Date.birthday,
              password: 'password', gender: ["male", "female"].sample,
              email: Faker::Internet.email)
end

10.times do
  Survey.create(title: Faker::Lorem.word, creator_id: rand(3))
end

50.times do
  Question.create(prompt: Faker::Lorem.sentence, survey_id: rand(10))
end

question_ids = []
4.times do
  50.times do |num|
    question_ids << num + 1
  end
end

200.times do
  Choice.create(answer: Faker::Lorem.words,
                question_id: question_ids.delete_at(rand(question_ids.length)))
end
