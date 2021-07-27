require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

before do
  @user_list = YAML.load(File.read("data/users.yml"))
end

helpers do
  def count_interests; end
end

# application should have layout that has a summary of # of all current users and sum of their interests
  # use helper method count_interests
# add new user to users.yaml file and verify that the site updates accordingly

get "/" do
  erb @user_list
  # home page should redirect to a page that lists all of the users' names from users.yml
end

get "/add_new" do # WISHLIST: add functionality for adding new users via app
  redirect "/"
end

get "/user/*" do
# each user name should be a link to a page for that user
  # display email address, list of interests with a comma separating in between
  # include menu at bottom of each users's page with a link to all the other users (not including current user)
end

not_found do # WISHLIST: add custom error message?
  redirect "/"
end