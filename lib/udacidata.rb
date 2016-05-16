require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  attr_reader :id, :brand, :name, :price
  #Define method to create a new product.
  def self.create(options = {})
    @product = Product.new(options)
    @id = @product.id
    @brand = @product.brand
    @name = @product.name
    @price = @product.price
    Module::create_finder_methods("id", "brand", "name", "price")
    @data_path = File.dirname(__FILE__) + "/../data/data.csv"
    CSV.open(@data_path, "a") do |csv|
      csv << ["#{@product.id}", "#{@product.brand}", "#{@product.name}", "#{@product.price}"]
    end
    @products.push(@product)
    return @product
  end

  def self.all
    @products
  end

  def self.first(length = 1)
    if length == 1
      @products.first
    else
      @products.first(length)
    end
  end

  def self.last(length = 1)
    if length != 1
      @products.last(length)
    else
      @products.last
    end
  end

  def self.find(index)
    return @products.at((index-1))
  end

  def self.destroy(position)
    arr = CSV.read(@data_path, headers: true)
    arr.delete(arr[position - 1])
    CSV.open(@data_path, "w+") do |csv|
      arr.each do |row|
        csv << ["#{row["id"]}"," #{row["brand"]}"," #{row["name"]}"," #{row["price"]}"]
      end
    end
    return @products.delete_at(position - 1)
  end

  def update(options = {})
    @data_path = File.dirname(__FILE__) + "/../data/data.csv"
    arr = CSV.read(@data_path, headers: true)
    CSV.open(@data_path, "w+") do |output|
      change = arr[self.id - 1]
      change["brand"] = options[:brand] if options[:brand]
      change["product"] = options[:name] if options[:name]
      change["price"] = options[:price] if options[:price]
      output << ["id","brand","product","price"]
      arr.each do |row|
        if row["id"] == self.id - 1
          output << ["#{change["id"]}", "#{change["brand"]}", "#{change["product"]}", "#{change["price"]}"]
        else
          output << ["#{row["id"]}","#{row["brand"]}","#{row["product"]}","#{row["price"]}"]
        end
      end
    end
    @brand = options[:brand] if options[:brand]
    @name = options[:name] if options[:name]
    @price = options[:price] if options[:price]
    return self
  end
end
