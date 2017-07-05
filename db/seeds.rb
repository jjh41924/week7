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
                 user_id: User.sample.id
end

# Reset the 'reviews' table
Review.delete_all

# Reset the 'orders' table
Order.delete_all
