class CreateTableUsers < Sequel::Migration
  def up
    create_table :users do
      primary_key :id
      column :username, :string
    end
  end

  def down
    drop_table :users
  end
end