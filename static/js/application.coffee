window.Microtext = class Microtext extends Batman.App
  @root 'posts#index'

class Microtext.PostsController extends Batman.Controller
  routingKey: 'posts'

  constructor: ->
    super
    @set 'newPost', new Microtext.Post(text: "")

  createPost: ->
    @get('newPost').save (err, todo) =>
      if err
        throw err
      else
        @set 'newPost', new Microtext.Post(text: "")

  index: ->
    Microtext.Post.load (err, records) =>
      @set 'posts', Microtext.Post.get('all').sortedBy('updated_at', 'desc')

class Microtext.Post extends Batman.Model
  @persist Batman.RestStorage
  @encode 'text', 'created_at', 'updated_at'
  @resourceName: 'post'

  @accessor 'updated_at_pretty', get: -> prettyDate(@get('updated_at'))

$ ->
  Microtext.run()
