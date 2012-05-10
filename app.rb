require 'rubygems'
require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/synchrony'
require 'sinatra/reloader'
require 'sinatra/assetpack'
require 'haml'
require './models'

class Microtext < Sinatra::Base
  register Sinatra::Synchrony
  register Sinatra::AssetPack
  use Rack::CommonLogger

  configure :development do
    register Sinatra::Reloader
  end

  assets do
    serve '/js',  from: 'static/js'
    serve '/css', from: 'static/css'

    js :app, '/js/app.js', ['/js/*.js']

    js_compression  :jsmin
    css_compression :sass
  end

  get '/' do
    @posts = Post.all
    haml :index
  end

  post '/new' do
    Post.create(text: params[:text])
    redirect to('/')
  end

  delete '/:id' do
    Post.get(params[:id]).destroy
    redirect to('/')
  end
end
