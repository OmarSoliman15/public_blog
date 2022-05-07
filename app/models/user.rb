class User < Sequel::Model(DB)
  associate :one_to_many, :posts
  one_to_many :feedback, :as => :model
end