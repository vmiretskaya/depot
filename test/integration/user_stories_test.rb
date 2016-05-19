require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products
  
  test "buying a product" do
	  LineItem.delete_all
	  Order.delete_all
	  ruby_book = products(:ruby)

	  #user opens app
	  get "/"
	  assert_response :success
	  assert_template "index"
	  
	  # user chooses a product
	  xml_http_request :post '/line_items', product_id: ruby_book.product_id
	  assert_response :success

	  cart = Cart.find(session[:cart_id])
	  assert_equal 1, cart.line_items.size
	  assert_equal ruby_book, cart.line_items[0].product
	  
	  #user creates order
	  get "/orders/new"
	  assert_response :success
	  assert_template "new"
	  
	  #post order
	  post_via_redirect "/orders", 
	  	order: {name: "Dave Thomas", 
	  			address: "123 the street",
	  			email: "dave@ex.com",
	  			pay_type: "Check"
	  		    }
	  assert_response :success
	  assert_template "index"
	  cart = Cart.find(session[:cart_id])
	  assert_equal 0, cart.line_items.size		    
	  
	  # check the database
	  orders  = Order.all
	  assert_equal 1, order.size
	  order = orders[0]
	  assert_equal "Dave Thomas", order.name
	  assert_equal "123 the street", order.address
	  assert_equal "dave@ex.com", order.email

	  assert_equal 1, order.line_items.size
	  line_item = order.line_items[0]
	  assert_equal ruby_book, line_item.product
	  
	  #mail
	  mail = ActionMailer::Base.deliveries.last
	  assert_equal ["dave@ex.com"], mail.to
	  assert_equal 'Sam Ruby <depot@ex.com>', mail[:from].value
	  assert_equal "Order Confirmation"
	end  
end
