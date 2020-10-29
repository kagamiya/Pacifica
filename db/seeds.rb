# sample users
User.create!(name: "kagamiya",
             email: "kagamiya@example.com",
             password: "foobar",
             password_confirmation: "foobar",
             profile: Faker::Lorem.sentence(word_count: 15),
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "user-#{n+1}@pacifica.com"
  password = "password"
  profile = Faker::Lorem.sentence(word_count: 15)
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               profile: profile)
end

# sample posts associated with users
#users = User.order(:created_at).take(6)
#50.times do
  #content = Faker::Lorem.sentence(word_count: 5)
  #name = Faker::Music.album
  #artist = Faker::Music.band
  #artwork = 'sample2.png'
  #collection_id = Faker::Number.number(digits: 10)
  #users.each do |user|
    #user.posts.create!(content: content,
                       #music_attributes: { name: name,
                                           #artist: artist,
                                           #artwork: artwork,
                                           #collection_id: collection_id })
  #end
#end

# sample relationships
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
