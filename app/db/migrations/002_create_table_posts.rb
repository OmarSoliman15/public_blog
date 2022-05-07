class CreateTablePosts < Sequel::Migration
  def up
    create_table :posts do
      primary_key :id
      column :author_ip, :string
      column :user_id, :integer
      column :title, :string
      column :content, :text
      column :rate_sum, :float, default: 0
      column :rate_value, :float, default: 0
      column :rate_count, :integer, default: 0
      index :author_ip
      index :title
    end
  end

  def down
    drop_table :posts
  end
end