require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

user_list = YAML.load(File.read("/data/users.yml"))