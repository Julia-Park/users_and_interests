require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

before do
  @users = YAML.load(File.read("data/users.yml"))
  @user_list = @users.keys
end

helpers do
  def count_interests
    @users.values.reduce(0) do |total, data|
      total + data[:interests].size
    end
  end

  def html_link(url, display_text, additional_attributes="")
    "<a href=""#{url}"" #{additional_attributes}>#{display_text}</a>"
  end

  def generate_navigation_links(user_name)
    eligible_profiles = @user_list.select { |name| name.to_s != user_name }
    eligible_profiles.map { |name| html_link("/user/#{name}", name)}.join("  |  ")
  end
end

# application should have layout that has a summary of # of all current users and sum of their interests
  # use helper method count_interests
# add new user to users.yaml file and verify that the site updates accordingly

get "/" do
  @title = "User List"
  erb :home
end

get "/add_new" do # WISHLIST: add functionality for adding new users via app
  redirect "/"
end

get "/user/:name" do
  @title = params[:name].capitalize
  erb :profile
end

not_found do # WISHLIST: add custom error message?
  redirect "/"
end