$ ->
  $("#posts-container").each( ->
    new CFB.Posts()
  )

CFB.Posts = class Posts

  constructor: ->
    @next_page = 1
    @$more_link = $("a#more-posts")
    @init_events()
    @fetch_posts()
    
  init_events: ->
    @$more_link.click =>
      @fetch_posts()

  fetch_posts: ->
    $.ajax
      url: "/newsfeed/posts/page/#{@next_page}.json",
      type: 'get',
      datatype: 'json',
      success: (data, textstatus, xhr) =>
        @add_posts(data)
        if @next_page < data.num_pages
          @next_page += 1
        else
          @$more_link.hide()

      error: (response) ->
        console.log response

  add_posts: (data) ->
    posts_data = data.posts
    tmpl = JST["post"]
    posts = ''
    _.each(posts_data, (post) ->
      posts += tmpl(id: post.id, name: post.user.name, avatar_url: post.user.avatar_url, text: post.text, video_type: post.video_type, video_id: post.video_id)
    )
    $("#posts-container").append(posts)
