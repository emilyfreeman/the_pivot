
# 50 items per category
# 100 registered customers <-- hold off to save AWS upload times
# 10 orders per registered customer

class Seed
  def self.start
    seed = Seed.new
    seed.generate_roles
    seed.generate_categories
    seed.generate_stores
    seed.generate_pending_stores
    seed.generate_declined_stores
    seed.generate_items
    seed.generate_users
    seed.generate_josh
    seed.generate_admins
    seed.generate_justin_admin
    seed.generate_emily_admin
    seed.generate_jason_admin
    seed.generate_john_admin
    seed.generate_andrew_admin
    seed.generate_platform_admin
    seed.generate_orders
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
        image: "https://robohash.org/#{i}.png",
        category_id: Random.new.rand(1..Category.count),
        store_id: Random.new.rand(1..Store.count)
        )
      puts "Item #{i}: #{item.name} created!"
    end
  end

  def generate_orders
    User.all.each do |user|
      10.times do |i|
        order = user.orders.create!(total_price: "#{i + 1 * 10}")
        add_item_orders(order)
        puts "Order #{order.id}: Order for #{user.username} created!"
      end
    end
  end

  def generate_stores
    20.times do |i|
      store = Store.create!(
        name: Faker::Company.name,
        status: "accepted",
        bio: Faker::Lorem.paragraph,
        image: "https://robohash.org/#{i}.png"
      )
      puts "Store #{i}: #{store.name} created!"
    end
  end

  def generate_pending_stores
    3.times do |i|
      store = Store.create!(
        name: Faker::Company.name,
<<<<<<< HEAD
        status: "pending",
=======
        status: "Pending",
>>>>>>> 981900ba763b4a3bae02b90b7feb9693d983e732
        bio: Faker::Lorem.paragraph,
        image: "https://robohash.org/#{i}.png"
      )
      puts "Store #{i}: #{store.name} created!"
    end
  end

<<<<<<< HEAD
  def generate_declined_stored
=======
  def generate_declined_stores
>>>>>>> 981900ba763b4a3bae02b90b7feb9693d983e732
    5.times do |i|
      store = Store.create!(
        name: Faker::Company.name,
        status: "declined",
        bio: Faker::Lorem.paragraph,
        image: "https://robohash.org/#{i}.png"
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
        bio: Faker::Lorem.paragraph,
        image: "https://robohash.org/#{i}.png"
      )
      user.roles << Role.find(3)
    end
  end

  def generate_josh
    user = User.create!(
      first_name: "Josh",
      last_name: "Mejia",
      username: "josh@turing.io",
      password: "password",
      bio: "legendary mod 3 instructor",
      image: "http://turing.io/images/p_josh_m_gray-e0b2801d.jpg"
    )
    user.roles << Role.find(3)
  end

  def generate_admins
    20.times do |i|
      admin = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        username: "business admin #{i + 1}",
        password: "bapassword#{i + 1}"
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
        password: "password",
        image: "https://robohash.org/justin.png"
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
        password: "password",
        image: "https://robohash.org/emily.png"
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
        password: "password",
        image: "https://robohash.org/jason.png"
      )
      admin.roles << Role.find(2)
      add_stores(admin, 3)
      puts "User #{admin.first_name}: stores created!"
  end

  def generate_john_admin
      admin = User.create!(
        first_name: "John",
        last_name: "Slota",
        username: "johnslota",
        password: "password",
        image: "https://robohash.org/generic.png"
      )
      admin.roles << Role.find(2)
      add_stores(admin, 4)
      puts "User #{admin.first_name}: stores created!"
  end

<<<<<<< HEAD
  def generate_andrew_admin
      admin = User.create!(
        first_name: "Andrew",
        last_name: "Carmer",
        username: "andrew@turing.io",
        password: "password",
        image: "http://turing.io/images/p_andrew_gray-c6db8a4a.jpg"
      )
      admin.roles << Role.find(2)
      add_stores(admin, 5)
      puts "User #{admin.first_name}: stores created!"
  end
=======
  def generate_platform_admin
    platform_admin = User.create!(
      first_name: "Jorge",
      last_name: "Rodrigues",
      username: "jorge@turing.io",
      password: "password"
    )
    platform_admin.roles << Role.find(1)
    puts "Platform admin #{platform_admin.first_name}: created!"
  end

  private
>>>>>>> 981900ba763b4a3bae02b90b7feb9693d983e732

  def generate_platform_admin
    platform_admin = User.create!(
      first_name: "Jorge",
      last_name: "Rodrigues",
      username: "jorge@turing.io",
      password: "password",
      image: "http://turing.io/images/p_jorge_gray-30310ede.jpg"
      )
    platform_admin.roles << Role.find(1)
    puts "Platform admin #{platform_admin.first_name}: created!"
  end

  private

    def add_stores(user, count)
      store = Store.find(count + 1)
      store.users << user
    end

    def add_item_orders(order)
      5.times do |i|
        item = Item.find(Random.new.rand(1..50))
        item_order = order.item_orders.create!(item_id: item.id,
                                               quantity: (i + 1),
                                               subtotal: item.price * (i +1),
                                               store_id: item.store.id)
        puts "Added item #{item.name} to order #{order.id}."
      end
    end

end

Seed.start
