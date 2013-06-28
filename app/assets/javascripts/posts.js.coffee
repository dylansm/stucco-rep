$ ->
  $("#posts-container").each( ->
    new CFB.Posts()
  )

CFB.Posts = class Posts

  constructor: ->
    @next_page = 2
    @init_events()
    
  init_events: ->
    $("a#more-posts").click =>
      @fetch_posts()

  fetch_posts: ->
    $.ajax
      url: "/newsfeed/posts?page=#{@next_page}",
      type: 'get',
      datatype: 'json',
      success: (data, textstatus, xhr) =>
        @add_posts(data)
      error: (response) ->
        console.log response

  add_posts: (data) ->
    tmpl = JST["post"]
    posts = ''
    _.each(data, (post) ->
      posts += tmpl(id: post.id, name: post.user.name, avatar_url: post.user.avatar_url, text: post.text)
    )
    console.log posts
    $("#posts-container").append(posts)
    console.log data
