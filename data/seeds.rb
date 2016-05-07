require 'faker'

# This file contains code that populates the database with
# fake data for testing purposes

def db_seed
  # Your code goes here!
  10.times do
    product = Product.create(name: Faker::Commerce.product_name)
  end
end
