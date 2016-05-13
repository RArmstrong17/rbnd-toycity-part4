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
  end
end
