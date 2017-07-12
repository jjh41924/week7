# Reset the 'users' table
User.delete_all
cookie_monster = User.create name: 'Cookie Monster', email: 'cookies@example.com', password: 'cookies'
margaret = User.create name: 'Margaret Hamilton', email: 'margaret@example.com', password: 'apollo'
alan = User.create name: 'Alan Turing', email: 'alan@example.com', password: 'enigma'
grace = User.create name: 'Grace Hopper', email: 'grace@example.com', password: 'counterclockwise'


# Reset the 'products' table
Product.delete_all
product_data = JSON.parse(open('db/product_examples.json').read)
product_data['products'].each do |data|
  p = Product.create title: data['title'],
                 price: data['price'],
                 description: data['description'],
                 user_id: User.sample.id,
                 photo_url: data['photo_url']
end

# Reset the 'reviews' table
Review.delete_all

Product.all.each do |product|
  4.times do
    Review.create product_id: product.id,
                  rating: [1,2,3,4,5].sample,
                  content: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  end
end

# Reset the 'orders' table
Order.delete_all
User.all.each do |user|
  rand(3..10).times do
    Order.create user_id: user.id, product_id: Product.sample.id, created_at: rand(1..14).days.ago
  end
end

puts "#{Product.count} products."
puts "#{Review.count} reviews."
puts "#{Order.count} orders."
