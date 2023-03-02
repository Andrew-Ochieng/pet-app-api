puts "🌱 Seeding users ..."

puts "1. Seeding users"
users = []

#main user
users << User.create(
  username: "person",
  password: "password"
)

#other users
10.times do
  users << User.create(
      username: Faker::Name.name,
      password: Faker::Internet.password(min_length: 8)
  )
end

puts "seeding pets"
50.times do
  Pet.create(
      user_id: users.sample.id,
      name: Faker::Creature::Cat.name,
      breed: Faker::Creature::Cat.breed,
      image_url: Faker::Avatar.image(slug: "my-own-slug", size: "50x50", format: "jpg")
  )
end

puts "✅ Done seeding!"
