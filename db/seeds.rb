puts "🌱 Seeding users ..."

# Make 10 users
10.times do
  User.create(
      username: Faker::Name.name,
      password: Faker::Internet.password(min_length: 8)
  )
end

  # Make 50 pets
50.times do
  Pet.create(
      user_id: user.id,
      name: Faker::Creature::Cat.name,
      breed: Faker::Creature::Cat.breed,
      image_url: Faker::Avatar.image(slug: "my-own-slug", size: "50x50", format: "jpg")
  )
end

puts "✅ Done seeding!"
