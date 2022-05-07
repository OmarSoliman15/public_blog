class Feedback < Sequel::Model(DB)

  def self.model_types
    %w[user post]
  end
end