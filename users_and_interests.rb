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

get "/" do
  @title = "User List"
  erb :home
end

get "/user/:name" do
  @title, destination =
    if @user_list.include?(params[:name].to_sym)
      [params[:name].capitalize, :profile]
    else 
      ["User Not Found", :not_found]
    end

  erb destination
end

not_found do
  @title = "Content Not Found"
  erb :not_found
end