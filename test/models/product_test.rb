require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # свойства товара не должны оставаться пустыми
test "product attributes must not be empty" do
	product = Product.new
		assert product.invalid?
		assert product.errors[:title].any?
		assert product.errors[:description].any?
		assert product.errors[:price ].any?
		assert product.errors[:image_url].any?
end

test "product price must be positive" do
	# цена товара должна быть положительной
	product = Product.new(title: "My Book Title",
						  description: "yyy ",
						  image_url: "zzz.jpg")
	product.price = -1
	assert product.invalid?
	assert_equal "must be greater than or equal to 0.01",
	product.errors[:price].join('; ')
	
	# должна быть больше или равна 0.01
	product.price = 0
	assert product.invalid?
	assert_equal "must be greater than or equal to 0.01",
	product.errors[:price].join('; ')
	product.price = 1
	assert product.valid?
end

test "title length must be greater than 10" do
	# длина имени продукта должна быть больше 10
	product = Product.new(title: "",
						  description: "yyy ",
						  image_url: "zzz.jpg")
	product.title = "My book"
	assert product.invalid?
	assert_equal "is too short (minimum is 10 characters)",
	product.errors[:title].join('; ')
	
	product.title = "My book with length 10"
	assert product.valid?
end

end
