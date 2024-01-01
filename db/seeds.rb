require 'faker'

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create roles
Role.create!([{
                name: "Admin",
              }, {
                name: "Moderator"
              }, {
                name: "User"
              }])
p "Created #{Role.count} roles."

# Create dummy users
User.create!([{
                email: "willie_buchanan@testuser.com",
                username: "willie89",
                first_name: "Willie",
                last_name: "Buchanan",
                password: "P@ssw0rd",
                password_confirmation: "P@ssw0rd",
              },
              {
                email: "andrea_everett@testuser.com",
                username: "andrea02",
                first_name: "Andrea",
                last_name: "Everett",
                password: "P@ssw0rd",
                password_confirmation: "P@ssw0rd",
              }, {
                email: "chloe_vaughan@testuser.com",
                username: "chloe27",
                first_name: "Chloe",
                last_name: "Vaughan",
                password: "P@ssw0rd",
                password_confirmation: "P@ssw0rd",
              }, {
                email: "roberta_mooney@testuser.com",
                username: "roberta03",
                first_name: "Roberta",
                last_name: "Mooney",
                password: "P@ssw0rd",
                password_confirmation: "P@ssw0rd",
              }, {
                email: "malachy_moses@testuser.com",
                username: "malachy92",
                first_name: "Malachy",
                last_name: "Moses",
                password: "P@ssw0rd",
                password_confirmation: "P@ssw0rd",
              }, {
                email: "adrian_melendez@testmod.com",
                username: "adrian",
                first_name: "Adrian",
                last_name: "Melendez",
                role_id: 2,
                password: "iAmDaModP@ssw0rd",
                password_confirmation: "iAmDaModP@ssw0rd",
              }, {
                email: "rafferty_friedman@testuser.com",
                username: "rafferty85",
                first_name: "Rafferty",
                last_name: "Friedman",
                password: "P@ssw0rd",
                password_confirmation: "P@ssw0rd",
              }, {
                email: "marwa_alvarado@testuser.com",
                username: "marwa93",
                first_name: "Marwa",
                last_name: "Alvarado",
                password: "P@ssw0rd",
                password_confirmation: "P@ssw0rd",
              }, {
                email: "tara_stark@testadmin.com",
                username: "tara",
                first_name: "Tara",
                last_name: "Stark",
                role_id: 1,
                password: "iAmDaAdminP@ssw0rd",
                password_confirmation: "iAmDaAdminP@ssw0rd",
              }, {
                email: "esmee_cantu@testuser.com",
                username: "esmee31",
                first_name: "Esmee",
                last_name: "Cantu",
                role_id: 3,
                password: "P@ssw0rd",
                password_confirmation: "P@ssw0rd",
              }])
p "Created #{User.count} users."

# Create dummy categories
Category.create!([{
                    name: "Discussion",
                    description: "For general discussion about topics relating to the university.",
                  }, {
                    name: "Question",
                    description: "A QnA thread.",
                  }, {
                    name: "Looking for Advice",
                    description: "Seeking advice.",
                  }, {
                    name: "Campus / Hall",
                    description: "For topics centered around on campus stuff.",
                  }, {
                    name: "Module",
                    description: "Module related discussions",
                  }, {
                    name: "Meme",
                    description: "Memes, need I say more?",
                  }, {
                    name: "Misc",
                    description: "Miscellaneous threads.",
                  }, {
                    name: "Announcements",
                    description: "Official announcements from the forum staff.",
                  }])
p "Created #{Category.count} categories."

# Create dummy statuses
Status.create!([{
                  name: "open",
                }, {
                  name: "locked",
                }, {
                  name: "stickied",
                }])
p "Created #{Role.count} statuses."

# Create dummy posts
Post.create!(title: "Welcome to LiveNUS",
             body: "Welcome to the forum!, Feel free to introduce yourself in this thread!",
             user_id: 9,
             category_id: 8,
             status_id: 3)
20.times do |index|
  Post.create!(title: Faker::Book.title,
               body: Faker::Lorem.sentence(word_count: 10, supplemental: false, random_words_to_add: 10).chop,
               user_id: rand(1..10),
               category_id: rand(1..7),
               status_id: 1)
end
p "Created #{Post.count} posts."

# Create dummy comments
(1..21).each do |index|
  10.times do |i|
    Comment.create!(body: Faker::Lorem.sentence(word_count: 10, supplemental: false, random_words_to_add: 10).chop,
                    user_id: rand(1..10),
                    post_id: index)
  end
end
p "Created #{Comment.count} comments."
