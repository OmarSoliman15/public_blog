class CreateTableFeedbacks < Sequel::Migration
  def up
    create_table :feedbacks do
      primary_key :id

      column :model_type, :string
      column :model_id, :integer
      column :owner_id, :integer
      column :comment, :string

      index [:model_id, :model_type]
    end
  end

  def down
    drop_table :feedbacks
  end
end