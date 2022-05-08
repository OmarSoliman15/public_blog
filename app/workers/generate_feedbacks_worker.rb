class GenerateFeedbacksWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  def perform
    user_feedbacks =  User.join(:feedbacks).limit(2).select(:username, :comment, :model_type)
    post_feedbacks =  Post.join(:feedbacks).limit(2).join(:users).select(:username, :comment, :model_type, :rate_value)

    xml = Builder::XmlMarkup.new(:target => @output, :indent => 1)

    xml.instruct!
    xml.feedbacks do
      user_feedbacks.each do |feedback|
        xml.feedback do
          xml.username feedback[:username]
          xml.comment feedback[:comment]
          xml.model_type feedback[:model_type]
          xml.ratings ''
        end
      end
      post_feedbacks.each do |feedback|
        xml.feedback do
          xml.username feedback[:username]
          xml.comment feedback[:comment]
          xml.model_type feedback[:model_type]
          xml.ratings feedback[:ratings]
        end
      end
    end
    out_file = File.new(Date.today.to_s + ".txt", "w")
    out_file.puts(xml.to_s)
    out_file.close
  end
end