class PostsController < Controller
  def index
    unless params['limit']
      self.validation_error("Invalid limit")
      return get_attributes
    end
    posts = Post.limit(params['limit']).order(Sequel.desc(:rate_value))
    set_content(posts.select(:id, :title, :content).to_hash.to_s)
    get_attributes
  end

  def create
    unless params['title'] && params['content'] && params['author_ip'] && params['username']
      self.validation_error("missing parameters")
      return get_attributes
    end

    user = User.find_or_create(username: params['username'])

    Post.create(author_ip: params['author_ip'],
                title: params['title'],
                content: params['content'],
                user: user,
    )
    get_attributes
  end

  def rate
    unless params['post_id'] && params['value'] && Post.where(id: params['post_id']).exists &&
      (is_numeric? params['value']) && params['value'].to_i >= 1 && params['value'].to_i <= 5
      self.validation_error("missing parameters")
      return get_attributes
    end

    post = Post.where(id: params['post_id']).first
    post.calculate_rate(params['value'].to_i)
    get_attributes
  end

  def ip_authors
    ips = Post.join(:users).group_and_count(:author_ip, :username).having{Sequel.function(:count, :author_ip) > 1}.all

    set_content(ips.to_s)

    get_attributes
  end
end