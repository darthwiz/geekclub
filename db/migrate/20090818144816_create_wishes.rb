class CreateWishes < ActiveRecord::Migration
  def self.up
    create_table :wishes do |t|
      t.integer :user_id, :null => false
      t.integer :shop_id, :null => false
      t.string :sku, :limit => 40, :null => false
      t.string :description, :limit => 100, :null => false, :default => ''
      t.float :unit_price, :null => false, :default => 0
      t.float :quantity, :null => false, :default => 0
      t.timestamps
    end
    add_index :wishes, [ :shop_id, :user_id ]
  end

  def self.down
    drop_table :wishes
  end
end
