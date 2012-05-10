require 'data_mapper'
require 'dm-serializer'

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/microtext')

class Post
  include DataMapper::Resource

  property :id, Serial
  property :text, String
  timestamps :at
end

DataMapper.auto_upgrade!
