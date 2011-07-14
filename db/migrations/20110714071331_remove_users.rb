class RemoveUsers < ActiveRecord::Migration
  def self.up
    remove_column :quiz_takens, :user_id
    drop_table :users
  end

  def self.down
    add_column :quiz_takens, :user_id, :integer
    create_table "users", :force => true do |t|
      t.string    "provider"
      t.string    "uid"
      t.string    "name"
      t.timestamp "created_at"
      t.timestamp "updated_at"
    end
  end
end
