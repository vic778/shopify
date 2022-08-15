class Item < ApplicationRecord
    validates :name, presence: true
    validates :price, presence: true

    def to_s
        name
    end

    after_create do
        product = Stripe::Product.create(name: name)
        price = Stripe::Price.create(product: product.id, unit_amount: self.price, currency: 'usd')
        update(stripe_product_id: product.id)
    end
end
