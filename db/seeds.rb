class Seed
  def self.start
    seed = Seed.new
    seed.generate_roles
    seed.generate_categories
    seed.generate_stores
    seed.generate_items
    seed.generate_store_items
    seed.generate_users
    seed.generate_admins
  end

  def generate_roles
    Role.create!(name: "platform_admin")
    Role.create!(name: "business_admin")
    Role.create!(name: "registered_user")
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
    50.times do |i|
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
    20.times do |i|
      store = Store.create!(
        name: Faker::Company.name,
        status: "accepted",
        bio: Faker::Lorem.paragraph
      )
      puts "Store #{i}: Store #{store.name} created!"
    end
  end

  def generate_store_items
    20.times do |i|
      store = Store.find(i+1)
      add_items(store)
    end
  end

  def generate_users
    50.times do |i|
      user = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        username: Faker::Internet.user_name + "#{i}",
        password_digest: Faker::Internet.password
      )
      user.roles << Role.find(Random.new.rand(1..3))
    end
  end

  def generate_admins
    admins = User.joins(:roles).where(roles: { name: "business_admin" })
    admins.each do |admin|
      # add_stores(admin)
      puts "User #{admin.first_name}: stores created!"
      add_admins_to_stores(admin)
    end
  end

  private

  def add_admins_to_stores(admin)
    20.times do |i|
      store = Store.find(i+1)
      store.users << admin
    end
  end

  # def add_stores(user)
  #   2.times do |i|
  #     store = Store.offset(Random.new.rand(1..20))
  #     user.stores << store
  #     puts "#{i}: Added item #{store.name} to user #{user.id}."
  #   end
  # end

  def add_items(store)
    5.times do |i|
      item = Item.offset(Random.new.rand(1..50))
      store.items << item
      puts "#{i}: Added item #{item.name} to store #{store.id}."
    end
  end

end

Seed.start
