class Controller
  attr_reader :name, :action, :params
  attr_accessor :status, :headers, :content

  def initialize(name: nil, action: nil, params: nil)
    @name = name
    @action = action
    @params = get_params(params)
    @status = 200
    @headers = { "Content-Type" => "application/json" }
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

  def validation_error(content)
    @status = 421
    @headers = {}
    @content = [content]
    self
  end

  def get_attributes
    {
      status: @status,
      headers: @headers,
      content: @content
    }
  end

  def set_attributes(status = 200, headers = {}, content = ["OK"])
    @status = status
    @headers = headers
    @content = [content]

  end

  def set_status(status)
    @status = status
  end

  def set_content(content)
    @content = [content]
  end

  private def get_params(params)
    if params
      params.split('&').inject({}) do |result, q|
        k, v = q.split('=')
        if !v.nil?
          result.merge({ k => v })
        elsif !result.key?(k)
          result.merge({ k => true })
        else
          result
        end
      end
    end
  end
end