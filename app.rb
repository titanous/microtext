require 'rubygems'
require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/synchrony'
require 'sinatra/reloader'
require 'haml'
require './models'

class Microtext < Sinatra::Base
  register Sinatra::Synchrony
  use Rack::CommonLogger

  configure :development do
    register Sinatra::Reloader
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
