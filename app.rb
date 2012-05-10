require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'data_mapper'

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

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/microtext')

class Post
  include DataMapper::Resource

  property :id, Serial
  property :text, String
  timestamps :at
end

DataMapper.auto_upgrade!

__END__

@@ layout
%html
  = yield

@@ index
%div
  %form(action='/new' method='POST')
    %input(type='text' name='text')
    %input(type='submit')

  %div
    %ul
      - @posts.each do |post|
        %li= post.text
