# sample users
User.create!(name: "kagamiya",
             email: "kagamiya@example.com",
             password: "foobar",
             password_confirmation: "foobar",
             profile: Faker::Lorem.sentence(word_count: 15),
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "user-#{n}@pacifica.com"
  password = "password"
  profile = Faker::Lorem.sentence(word_count: 15)
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               profile: profile)
end

# sample relationships
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# sample posts associated with users
# 1
user = User.find(1)
content = Faker::Lorem.sentence(word_count: 50)
name = "Abbey Road (2019 Mix)"
artist = "The Beatles"
artwork = "https://is2-ssl.mzstatic.com/image/thumb/Music123/v4/6e/db/f5/6edbf5a8-b990-8f89-af12-8cc464f03da1/source/100x100bb.jpg"
collection_id = 1474815798
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

user = User.find(2)
content = Faker::Lorem.sentence(word_count: 50)
name = "Let It Bleed (Remastered)"
artist = "The Rolling Stones"
artwork = "https://is4-ssl.mzstatic.com/image/thumb/Music124/v4/1a/ee/d5/1aeed55e-0b32-183f-1916-a9036aa544c0/source/100x100bb.jpg"
collection_id = 1500642838
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

user = User.find(3)
content = Faker::Lorem.sentence(word_count: 50)
name = "Portrait In Jazz"
artist = "Bill Evans"
artwork = "https://is4-ssl.mzstatic.com/image/thumb/Music118/v4/32/8d/a5/328da5ed-a87d-fa86-e262-ffcd3de4d03c/source/100x100bb.jpg"
collection_id = 1440925629
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

user = User.find(4)
content = Faker::Lorem.sentence(word_count: 50)
name = "Give Me the Night"
artist = "George Benson"
artwork = "https://is5-ssl.mzstatic.com/image/thumb/Music/v4/3f/87/9b/3f879b85-4328-be0b-f5ac-7eb68a68f21c/source/100x100bb.jpg"
collection_id = 309576571
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

user = User.find(5)
content = Faker::Lorem.sentence(word_count: 50)
name = "Passion Session"
artist = "Don Ross"
artwork = "https://is5-ssl.mzstatic.com/image/thumb/Music/v4/c1/36/a2/c136a2e3-6167-6729-a4d2-c30f52bf0347/source/100x100bb.jpg"
collection_id = 723480170
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

user = User.find(6)
content = Faker::Lorem.sentence(word_count: 50)
name = "Wes Bound"
artist = "Lee Ritenour"
artwork = "https://is1-ssl.mzstatic.com/image/thumb/Music128/v4/33/55/21/33552135-fb13-293e-e56e-9e0e05a6a172/source/100x100bb.jpg"
collection_id = 1444042577
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

# 2
user = User.find(1)
content = Faker::Lorem.sentence(word_count: 50)
name = "Let It Be"
artist = "The Beatles"
artwork = "https://is2-ssl.mzstatic.com/image/thumb/Music118/v4/63/9b/2c/639b2caf-0186-39c3-b165-cac5eae1f38e/source/100x100bb.jpg"
collection_id = 1441164495
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

user = User.find(2)
content = Faker::Lorem.sentence(word_count: 50)
name = "Beggars Banquet (Remastered)"
artist = "The Rolling Stones"
artwork = "https://is4-ssl.mzstatic.com/image/thumb/Music124/v4/ab/ab/a5/ababa5bc-c507-6f62-0c2c-6dc665b21d51/source/100x100bb.jpg"
collection_id = 1500643395
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

user = User.find(3)
content = Faker::Lorem.sentence(word_count: 50)
name = "Waltz for Debby"
artist = "Bill Evans Trio"
artwork = "https://is3-ssl.mzstatic.com/image/thumb/Music118/v4/8c/96/4a/8c964af7-f9b5-278c-a8c8-a6ebf330621a/source/100x100bb.jpg"
collection_id = 1440747830
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

user = User.find(4)
content = Faker::Lorem.sentence(word_count: 50)
name = "Breezin'"
artist = "George Benson"
artwork = "https://is1-ssl.mzstatic.com/image/thumb/Music1/v4/f8/a2/5b/f8a25ba6-32da-6003-e30f-d32f4f5ec553/source/100x100bb.jpg"
collection_id = 1018562855
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

user = User.find(5)
content = Faker::Lorem.sentence(word_count: 50)
name = "The Thing That Came from Somewhere"
artist = "Don Ross"
artwork = "https://is2-ssl.mzstatic.com/image/thumb/Music/v4/7d/9e/ad/7d9ead09-f7cd-6774-dc35-21179e92da20/source/100x100bb.jpg"
collection_id = 272278318
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

user = User.find(6)
content = Faker::Lorem.sentence(word_count: 50)
name = "The Captain's Journey"
artist = "Lee Ritenour"
artwork = "https://is2-ssl.mzstatic.com/image/thumb/Music124/v4/40/0c/58/400c58b9-c977-963d-6af4-7577fbebc39b/source/100x100bb.jpg"
collection_id = 1449226363
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

# 3
user = User.find(1)
content = Faker::Lorem.sentence(word_count: 50)
name = "Rubber Soul"
artist = "The Beatles"
artwork = "https://is4-ssl.mzstatic.com/image/thumb/Music128/v4/4b/3b/6f/4b3b6fd1-56d9-db57-a599-86e9a3579fd3/source/100x100bb.jpg"
collection_id = 1441164359
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

user = User.find(2)
content = Faker::Lorem.sentence(word_count: 50)
name = "Sticky Fingers"
artist = "The Rolling Stones"
artwork = "https://is1-ssl.mzstatic.com/image/thumb/Music118/v4/ad/8f/2d/ad8f2dda-c575-2097-6151-31452deb140c/source/100x100bb.jpg"
collection_id = 1440812661
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

user = User.find(3)
content = Faker::Lorem.sentence(word_count: 50)
name = "Affinity"
artist = "Bill Evans"
artwork = "https://is4-ssl.mzstatic.com/image/thumb/Music124/v4/80/4b/22/804b22ab-a41d-e517-5fcc-fe55c45cb00e/source/100x100bb.jpg"
collection_id = 1449245229
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

user = User.find(4)
content = Faker::Lorem.sentence(word_count: 50)
name = "20/20"
artist = "George Benson"
artwork = "https://is4-ssl.mzstatic.com/image/thumb/Music/v4/4b/3d/fe/4b3dfe24-b0f7-1c45-0dbf-ee814795cbcf/source/100x100bb.jpg"
collection_id = 300946432
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

user = User.find(5)
content = Faker::Lorem.sentence(word_count: 50)
name = "Don Ross"
artist = "Don Ross"
artwork = "https://is5-ssl.mzstatic.com/image/thumb/Music/v4/43/c9/50/43c950b0-ee9f-13d0-a178-4017f137f64a/source/100x100bb.jpg"
collection_id = 203411253
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

user = User.find(6)
content = Faker::Lorem.sentence(word_count: 50)
name = "Captain Fingers"
artist = "Lee Ritenour"
artwork = "https://is3-ssl.mzstatic.com/image/thumb/Music/v4/9b/37/da/9b37dae9-a67b-2fd9-494d-324cc86ffaf2/source/100x100bb.jpg"
collection_id = 185858011
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

# 4
user = User.find(1)
content = Faker::Lorem.sentence(word_count: 50)
name = "The Beatles 1967-1970 (The Blue Album)"
artist = "The Beatles"
artwork = "https://is5-ssl.mzstatic.com/image/thumb/Music128/v4/27/70/11/2770116d-0a57-f107-ba91-bd3679d44e5f/source/100x100bb.jpg"
collection_id = 1441133100
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

user = User.find(2)
content = Faker::Lorem.sentence(word_count: 50)
name = "Some Girls"
artist = "The Rolling Stones"
artwork = "https://is5-ssl.mzstatic.com/image/thumb/Music128/v4/4a/94/cd/4a94cd0d-5cf1-53a9-dd1f-8f7c36dff2f2/source/100x100bb.jpg"
collection_id = 1440816775
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

user = User.find(3)
content = Faker::Lorem.sentence(word_count: 50)
name = "Kind of Blue"
artist = "Miles Davis"
artwork = "https://is2-ssl.mzstatic.com/image/thumb/Music/v4/f3/d5/eb/f3d5eb6b-34f6-69db-1b2c-477c46ee7662/source/100x100bb.jpg"
collection_id = 268443092
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

user = User.find(4)
content = Faker::Lorem.sentence(word_count: 50)
name = "Guitar Man"
artist = "George Benson"
artwork = "https://is3-ssl.mzstatic.com/image/thumb/Music128/v4/71/18/09/711809ce-9ea1-38f8-0e7e-badbfd8f2d8d/source/100x100bb.jpg"
collection_id = 1440953216
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

user = User.find(5)
content = Faker::Lorem.sentence(word_count: 50)
name = "Upright & Locked Position"
artist = "Don Ross"
artwork = "https://is1-ssl.mzstatic.com/image/thumb/Music/v4/8f/d7/90/8fd790bc-b408-ed2c-d70f-212de129b69f/source/100x100bb.jpg"
collection_id = 516041771
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })

user = User.find(6)
content = Faker::Lorem.sentence(word_count: 50)
name = "Smoke 'n' Mirrors"
artist = "Lee Ritenour"
artwork = "https://is1-ssl.mzstatic.com/image/thumb/Music118/v4/a6/76/75/a67675f9-4213-0e3b-3b58-5c53801f013d/source/100x100bb.jpg"
collection_id = 1443923501
user.posts.create!(content: content,
                    music_attributes: { name: name,
                                        artist: artist,
                                        artwork: artwork,
                                        collection_id: collection_id })
