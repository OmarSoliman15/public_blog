class Controller
  attr_reader :name, :action
  attr_accessor :status, :headers, :content

  def initialize(name: nil, action: nil)
    @name = name
    @action = action
    @status = 200
    @headers = {"Content-Type" => "application/json"}
    @content = ["OK"]
  end

  def call
    send(action)
    self
  end

  def not_found
    @status = 404
    @headers = {}
    @content = ["Nothing found"]
    self
  end

  def internal_error
    @status = 500
    @headers = {}
    @content = ["Internal error"]
    self
  end

  def get_attributes
    {
      status: @status,
      headers: @headers,
      content: @content
    }
  end

  def set_status(status)
    @status = status
  end

  def set_content(content)
    @content = [content]
  end
end