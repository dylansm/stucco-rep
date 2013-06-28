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
    console.log data
