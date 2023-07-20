=begin
# Helper method to create random soccer equipment products
def create_product(category_id)
    Product.create(
      name: Faker::Commerce.product_name,
      stock: Faker::Number.between(from: 5, to: 100),
      price: Faker::Commerce.price(range: 10.0..200.0),
      category_id: category_id
    )
  end
  
  # Seed Categories
  categories = [
    { name: 'Soccer Balls', description: 'Various soccer balls for matches and training.' },
    { name: 'Soccer Cleats', description: 'Soccer shoes for different playing surfaces.' },
    { name: 'Goalkeeper Gloves', description: 'Gloves for soccer goalkeepers.' },
    { name: 'Training Equipment', description: 'Training gear for soccer players.' }
  ]
  
  Category.create(categories)
  
  # Seed Products
  categories = Category.all
  categories.each do |category|
    25.times do
      create_product(category.id)
    end
  end
=end
  # Update descriptions for existing products
Product.all.each do |product|
    product.update(description: Faker::Lorem.paragraph)
  end