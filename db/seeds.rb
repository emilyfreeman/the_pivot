require_relative 'image_links'

class Seed
  def self.start
    seed = Seed.new
    seed.generate_roles
    seed.generate_categories
    seed.generate_stores
    seed.generate_items
    seed.generate_users
    seed.generate_admins
    seed.generate_justin_admin
    seed.generate_emily_admin
    seed.generate_jason_admin
    seed.generate_generic_admin
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
        category_id: Random.new.rand(1..Category.count),
        store_id: Random.new.rand(1..Store.count)
        )
      puts "Item #{i}: #{item.name} created!"
    end
  end

  def generate_stores
    20.times do |i|
      # user = User.offset(Random.new.rand(1..20))
      store = Store.create!(
        name: Faker::Company.name,
        status: "accepted",
        bio: Faker::Lorem.paragraph,
        # image: ImageLinks::FARMER_IMAGE_URLS[i]
        # image: "http://robohash.org/#{i}.png"
      )
      puts "Store #{i}: #{store.name} created!"
    end
  end

  def generate_users
    10.times do |i|
      user = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        username: Faker::Internet.user_name + "#{i}",
        password_digest: Faker::Internet.password,
        bio: Faker::Lorem.paragraph
      )
      user.roles << Role.find(3)
    end
  end

  def generate_admins
    20.times do |i|
      admin = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        username: Faker::Internet.user_name + "#{i * 2}",
        password_digest: Faker::Internet.password
      )
      admin.roles << Role.find(2)
      add_stores(admin, i)
      puts "User #{admin.first_name}: stores created!"
    end
  end

  def generate_justin_admin
      admin = User.create!(
        first_name: "Justin",
        last_name: "Pease",
        username: "justinpease",
        password: "password"
      )
      admin.roles << Role.find(2)
      add_stores(admin, 1)
      puts "User #{admin.first_name}: stores created!"
  end

  def generate_emily_admin
      admin = User.create!(
        first_name: "Emily",
        last_name: "Dowdle",
        username: "emilydowdle",
        password: "password"
      )
      admin.roles << Role.find(2)
      add_stores(admin, 2)
      puts "User #{admin.first_name}: stores created!"
  end

  def generate_jason_admin
      admin = User.create!(
        first_name: "Jason",
        last_name: "Pilz",
        username: "jasonpilz",
        password: "password"
      )
      admin.roles << Role.find(2)
      add_stores(admin, 3)
      puts "User #{admin.first_name}: stores created!"
  end

  def generate_generic_admin
      admin = User.create!(
        first_name: "J",
        last_name: "Doe",
        username: "admin",
        password: "password"
      )
      admin.roles << Role.find(2)
      add_stores(admin, 4)
      puts "User #{admin.first_name}: stores created!"
  end

  private

  def add_stores(user, count)
    store = Store.find(count + 1)
    store.users << user
  end

end

Seed.start
