window.Microtext = class Microtext extends Batman.App
  @root 'posts#index'

class Microtext.PostsController extends Batman.Controller
  routingKey: 'posts'

  index: (params) ->
    Microtext.Post.load (err, records) -> throw err if err

class Microtext.Post extends Batman.Model
  @persist Batman.RestStorage
  @encode 'text', 'created_at', 'updated_at'
  @resourceName: 'post'

$ ->
  Microtext.run()
