class CreateShops < ActiveRecord::Migration
  def self.up
    create_table :shops do |t|
      t.string :name, :limit => 40, :null => false
      t.string :manager_name, :limit => 40, :null => false
    end
  end

  def self.down
    drop_table :shops
  end
end
