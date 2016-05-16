class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval
    attributes.each do |attribute|
       define_method(:"find_by_#{attribute}") do |arg|
        return @products.detect{|product| product.brand == arg} if attribute == "brand"
        return @products.detect{|product| product.name == arg} if attribute == "name"
        return @products.detect{|product| product.price == arg} if attribute == "price"
      end
    end
    define_method(:where) do |**arg|
      arg.each do |key, value|
        atrib = key.to_s
        @search = @products.find_all{|product| product.brand == value } if atrib == "brand"
        @search = @products.find_all{|product| product.name == value } if atrib == "name"
        @search = @products.find_all{|product| product.price == value } if atrib == "price"
      end
      return @search
    end
  end
end
