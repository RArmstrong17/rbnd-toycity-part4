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
    @products.push(@product)
    @data_path = File.dirname(__FILE__) + "/../data/data.csv"
    CSV.open(@data_path, "ab") do |csv|
      csv << ["#{@product.id}", "#{@product.brand}", "#{@product.name}", "#{@product.price}"]
    end
    Module::create_finder_methods("id", "brand", "name", "price")
    return @product
  end

  def self.all
    @products
  end

  def self.first(amount = 1)
    if amount == 1
      @products.first
    else
      @products.first(amount)
    end
  end

  def self.last(amount = 1)
    if amount != 1
      @products.last(amount)
    else
      @products.last
    end
  end

  def self.find(position)
    raise Product_ID_Doesnt_Exist, "There is no product with that ID" if position > @products.last.id.to_int
    @products.each do |product|
      if @products.any?{|product| product.id == position}
        @find = product if position == product.id
      else
        raise Product_ID_Doesnt_Exist, "There is no product with that ID"
      end
    end
    return @find
  end

  def self.destroy(position)
    raise Product_ID_Doesnt_Exist, "There is no product with that ID" if position > @products.last.id.to_int
    @products.each do |product|
      if @products.any?{|product| product.id == position}
        @to_delete = product if position == product.id
      else
        raise Product_ID_Doesnt_Exist, "There is no product with that ID"
      end
    end
    arr = CSV.read(@data_path, headers: true)
      CSV.open(@data_path, "w+") do |csv|
        csv << ["id","brand","product","price"]
          arr.each do |row|
            if row["id"] == position.to_s
            else
              csv << ["#{row["id"]}"," #{row["brand"]}"," #{row["product"]}"," #{row["price"]}"]
            end
          end
      end
    return @products.delete(@to_delete)
  end

  def update(options = {})
    @data_path = File.dirname(__FILE__) + "/../data/data.csv"
    arr = CSV.read(@data_path, headers: true)
    CSV.open(@data_path, "w+") do |output|
      arr.each do |row|
        @change = row if row["id"] == self.id.to_s
      end
      @change["brand"] = options[:brand] if options[:brand]
      @change["product"] = options[:name] if options[:name]
      @change["price"] = options[:price] if options[:price]
      output << ["id","brand","product","price"]
      arr.each do |row|
        if row["id"] == self.id
          output << ["#{self.id}", "#{@change["brand"]}", "#{@change["product"]}", "#{@change["price"]}"]
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
