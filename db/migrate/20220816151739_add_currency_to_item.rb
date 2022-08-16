class AddCurrencyToItem < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :currency, :string
  end
end
