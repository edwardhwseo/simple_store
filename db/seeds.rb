# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "csv"

Product.delete_all
Category.delete_all

# Grab the filename
filename = Rails.root.join("db/products.csv")
puts "Loading products from the csv file: #{filename}"

csv_data = File.read(filename)
products = CSV.parse(csv_data, headers: true, encoding: "utf-8")

products.each do |p|
    category = Category.find_or_create_by(name: p["category"])
    # See if category passes all validations
    if category.valid?
        # Create Product
        product = category.products.create(
            title: p["name"],
            price: p["price"],
            description: p["description"],
            stock_quantity: p["stock quantity"]
        )
    else
        puts "Invalid category #{p['category']} for product #{p['name']}"
    end
end

# 676.times do
#     product = Product.create(title: Faker::Appliance.equipment, 
#                              price: Faker::Commerce.price, 
#                              stock_quantity: Faker::Number.digit)
# end

# puts "#{Product.count} products created!"