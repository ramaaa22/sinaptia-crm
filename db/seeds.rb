# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create an example user for testing (dev only)
sinaptia = Company.create! name: "Sinaptia", description: "Sinaptia"
User.create! first_name: "Admin", last_name: "Admin", email: "admin@sinaptia.dev", password: "123456", password_confirmation: "123456", role: 1, company: sinaptia
User.create! first_name: "Default", last_name: "Default", email: "default@sinaptia.dev", password: "123456", password_confirmation: "123456", role: 0, company: sinaptia
