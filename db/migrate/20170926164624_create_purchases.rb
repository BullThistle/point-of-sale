class CreatePurchases < ActiveRecord::Migration[5.1]
  def change
    create_table :purchases do |t|
      t.column :item_id, :integer
      t.timestamps
    end
  end
end
