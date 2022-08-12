class Item < ApplicationRecord
    validates :name, presence: true
    validates :price, presence: true

    def to_s
        name
    end
end
