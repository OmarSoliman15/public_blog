class FeedbacksController < Controller
  def create
    if params['model_id'] && params['model_type'] && params['owner_id'] && params['comment'] &&
      (Feedback.model_types.include? params['model_type'])
      if params['model_type'] == 'user'
        model = User.where(id: params['model_id']).first
      else
        model = Post.where(id: params['model_id']).first
      end

      if model.nil?
        self.validation_error("invalid parameters")
        return get_attributes
      end

    else
      self.validation_error("invalid parameters")
      return get_attributes
    end

    feedback = Feedback.create(model_id: params['model_id'],
                    model_type: params['model_type'],
                    comment: params['comment'],
                    owner_id: params['owner_id'])
    set_content(Feedback.where(owner_id: params['owner_id']).to_hash.to_s)
    get_attributes
  end
end