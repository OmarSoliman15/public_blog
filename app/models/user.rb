class User < Sequel::Model(DB)
  associate :one_to_many, :posts
end