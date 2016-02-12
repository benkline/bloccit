require "random_data"

50.times do
  Post.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end
posts = Post.all

100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

#start assignment-30-idempotent_data
puts "#{Post.count} posts created"
  Post.find_or_create_by(
    title: "I am idempotent",
    body: "Trust me, this is a good thing."
  )

  puts "#{Comment.count} comments created"
    Comment.find_or_create_by(
      post: posts.sample,
      body: "Trust me, this is ACTUALLY a good thing."
    )

#end assignment-30-idempotent_data

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
