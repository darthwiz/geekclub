class CacheFbInfoInUsersTable < ActiveRecord::Migration
  def self.up
    remove_index :users, :facebook_id
    rename_column :users, :facebook_id, :fbid
    execute "ALTER TABLE users MODIFY fbid BIGINT"
    add_index :users, :fbid, :unique => true
    add_column :users, :first_name, :string, :limit => 80, :null => true, :default => nil
    add_column :users, :last_name, :string, :limit => 80, :null => true, :default => nil
    add_column :users, :picture, :string, :limit => 200, :null => true, :default => nil
  end

  def self.down
    rename_column :users, :fbid, :facebook_id
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :picture
    add_index :users, :facebook_id
  end
end
