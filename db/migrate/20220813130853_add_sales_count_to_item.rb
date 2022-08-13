class AddSalesCountToItem < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :sales_count, :integer, default: 0, null: false
  end
end
