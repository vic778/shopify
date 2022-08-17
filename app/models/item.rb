class Item < ApplicationRecord
  has_one_attached :image
  has_many_attached :pictures
  has_rich_text :body

  validates :name, presence: true
  validates :price, presence: true
  monetize :price, as: "price_cents"

  def to_s
    name
  end

  after_create do
    product = Stripe::Product.create(name: name)
    price = Stripe::Price.create(product: product.id, unit_amount: self.price, currency: currency)
    update(stripe_product_id: product.id, stripe_price_id: price.id)
  end

  after_update :create_and_assign_new_stripe_price, if: :saved_change_to_price?
  def create_and_assign_new_stripe_price
    # product = Stripe::Product.retrieve(stripe_product_id)
    price = Stripe::Price.create(product: stripe_product_id, unit_amount: self.price, currency: currency)
    update(stripe_price_id: price.id)
  end

  def to_builder
    Jbuilder.new do |product|
      product.price stripe_price_id
      product.quantity 1
    end
  end

  def image_as_thumbnail
    image.variant(resize_to_limit: [300, 300]).processed
  end
end
