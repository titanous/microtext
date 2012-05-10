require 'rubygems'
require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/synchrony'
require 'sinatra/reloader'
require 'sinatra/json'
require 'sinatra/assetpack'
require 'slim'
require './models'

class Microtext < Sinatra::Base
  register Sinatra::Synchrony
  register Sinatra::AssetPack
  helpers Sinatra::JSON
  use Rack::CommonLogger

  set :json_encoder, :to_json

  configure :development do
    register Sinatra::Reloader
  end

  assets do
    serve '/js',  from: 'static/js'
    serve '/css', from: 'static/css'

    js :app, '/js/app.js', %w(/js/jquery-1.7.2.js /js/batman.jquery.js /js/application.js /js/pretty_date.js)

    js_compression  :jsmin
    css_compression :sass
  end

  get '/' do
    @posts = Post.all
    slim :index
  end

  get '/posts' do
    json Post.all
  end

  post '/posts' do
    json Post.create(text: params[:post][:text])
  end

  delete '/posts/:id' do
    Post.get(params[:id]).destroy
  end
end
