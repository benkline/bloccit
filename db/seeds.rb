require "random_data"

# Create Users
5.times do
  User.create!(
  name:     Faker::Name.name,
  email:    Faker::Internet.email,
  password: Faker::Internet.password(8)
  )
end
users = User.all

#create topics
5.times do
  Topic.create!(
    name: Faker::Hacker.say_something_smart,
    description: Faker::Hipster.paragraph
  )
end
topics = Topic.all

#create posts
10.times do
  post = Post.create!(
    user: users.sample,
    topic: topics.sample,
    title: Faker::Hipster.sentence,
    body: Faker::Hipster.paragraph
  )

post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)

rand(1..5).times { post.votes.create!(value:[-1,1].sample, user: users.sample) }

end

posts = Post.all

#create comments
10.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: Faker::StarWars.quote
  )
end
10.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: Faker::Company.catch_phrase
  )
end
10.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: Faker::Hipster.sentence
  )
end

admin = User.create!(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'helloworld',
  role: 'admin'
)

member = User.create!(
  name: 'Member User',
  email: 'member@example.com',
  password: 'helloworld'
)

#print results
puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Vote.count} votes created"
