class User < Sequel::Model(DB)
  associate :one_to_many, :posts
  one_to_many :feedbacks, :as => :model
  one_to_many :owner_feedbacks, :key => :owner_id
end