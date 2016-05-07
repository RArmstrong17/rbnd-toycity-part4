require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  attr_reader :brand, :name, :price
  #Define method to create a new product.
  def self.create(options = {})
    @brand = options[:brand]
    @name = options[:name]
    @price = options[:price]
    @data_path = File.dirname(__FILE__) + "/../data/data.csv"
    file = File.open(@data_path, "a") do |csv|
      csv << "#{@brand} " + "#{@name} " + "#{@price} " + ""
      csv << "\n"
    end
  end
end
