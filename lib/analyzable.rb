module Analyzable
  # Your code goes here!
  def average_price(product_array)
    total_price = 0
    product_array.each do |product|
      total_price += product.price
    end
    avg_price = total_price/product_array.length
    return avg_price.round(2)
  end
  def print_report(products)
    product_array = []
    products.each do |product|
      product_array.push("#{product.id}, #{product.brand}, #{product.name}, #{product.price}")
    end
    product_array.join("; ")
  end
  def count_by_brand(product_array)
    count_hash = Hash.new(0)
    @brand_array = []
    product_array.each do |product|
      count_hash[product.brand] += 1
    end
    return count_hash
  end
  def count_by_name(product_array)
    count_hash = Hash.new(0)
    @name_array = []
    product_array.each do |product|
      count_hash[product.name] += 1
    end
    return count_hash
  end
end
