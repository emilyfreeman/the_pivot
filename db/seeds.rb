class Seed
  def self.start
    seed = Seed.new
    seed.generate_categories
    seed.generate_stores
    seed.generate_items
    seed.generate_admins
  end

  def generate_categories
    12.times do |i|
      category = Category.create!(
        name: Faker::Commerce.department
      )
      puts "Category #{i}: #{category.name} created!"
    end
  end

  def generate_items
    500.times do |i|
      item = Item.create!(
        name: Faker::Commerce.product_name,
        description: Faker::Lorem.paragraph,
        price: Faker::Commerce.price,
        image_file_name: "http://robohash.org/#{i}.png?set=set2&bgset=bg1&size=200x200",
        category_id: rand(1..Category.count),
        store_id: rand(1..Store.count)
        )
      puts "Item #{i}: #{item.name} created!"
    end
  end

  def generate_stores
    50.times do |i|
      user = User.offset(Random.new.rand(1..50))
      store = Store.create!(
        name: Faker::Company.name,
        status: "accepted",
        bio: Faker::Lorem.paragraph
      )
      add_items(store)
      puts "Store #{i}: Store for #{user.name} created!"
    end
  end

  def generate_admins
    20.times do |i|
      user = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        username: Faker::Internet.user_name,
        password_digest: Faker::Internet.password,
        role: 1
        )
      add_stores(user)
      puts "User #{i}: #{user.first_name} - #{user.username} created!"
    end
  end

  private

  def add_stores(user)
    2.times do |i|
      store = Store.offset(Random.new.rand(1..50))
      user.stores << store
      puts "#{i}: Added item #{store.name} to user #{user.id}."
    end
  end

  def add_items(store)
    10.times do |i|
      item = Item.offset(Random.new.rand(1..500))
      store.items << item
      puts "#{i}: Added item #{item.name} to store #{store.id}."
    end
  end

end

Seed.start
