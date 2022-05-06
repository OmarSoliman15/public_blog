class MainController < Controller
  def index
    set_content("Welcome to my public blog with ruby language")
    get_attributes
  end
end