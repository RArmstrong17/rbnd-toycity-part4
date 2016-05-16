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
    products.each do |product|
      return "#{product.id}, #{product.brand}, #{product.name}, #{product.price}"
    end
  end
  def count_by_brand(product_array)
    product_array.each do |product|
      @brand_count = product.brand
    end
    count_hash = Hash.new{|h,k| h[k] = nil}
    count_hash[@brand_count] = product_array.length
    return count_hash
  end
  def count_by_name(product_array)
    product_array.each do |product|
      @name_count = product.name
    end
    count_hash = Hash.new{|h,k| h[k] = nil}
    count_hash[@name_count] = product_array.length
    return count_hash
  end
end
