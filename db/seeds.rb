# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# テストユーザーの作成
puts "Creating test users..."

# テストユーザー1
test_user1 = User.find_or_create_by!(email_address: "test@example.com") do |user|
  user.password = "password123"
  user.password_confirmation = "password123"
end

# テストユーザー2
test_user2 = User.find_or_create_by!(email_address: "demo@example.com") do |user|
  user.password = "password123"
  user.password_confirmation = "password123"
end

# テストユーザー3
test_user3 = User.find_or_create_by!(email_address: "sample@example.com") do |user|
  user.password = "password123"
  user.password_confirmation = "password123"
end

puts "Test users created successfully!"
puts "Login credentials:"
puts "Email: test@example.com, Password: password123"
puts "Email: demo@example.com, Password: password123"
puts "Email: sample@example.com, Password: password123"
