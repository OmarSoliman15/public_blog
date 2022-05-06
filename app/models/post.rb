class Post < Sequel::Model(DB)

  def calculate_rate(value)
    self.rate_sum += value
    self.rate_count += 1
    self.rate_value = self.rate_sum / self.rate_count
    self.save
  end
end