class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.column :name, :string
      t.column :price, :integer
      t.column :description, :string
      t.timestamps
    end
  end
end
