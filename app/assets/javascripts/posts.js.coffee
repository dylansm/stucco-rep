$ ->
  $("#posts-container").each( ->
    new CFB.Posts()
  )

CFB.Posts = class Posts

  constructor: ->
    #alert 'ontouchstart' in window
    if window.Touch
      @touch_enabled = true
    @next_page = 1
    @$more_link = $("a#more-posts")
    @$create_submit = $("input[type=submit]")
    @init_events()
    @fetch_posts()
    
  init_events: ->
    if @touch_enabled
      @$more_link.bind("touchstart",
        => @fetch_posts()
      )

      #@$create_submit.bind("touchstart",
        #=> @create_post()
      #)

    else
      @$more_link.click =>
        @fetch_posts()
      #@$create_submit.click =>
        #@create_post()

    $("#new_post").on("ajax:success", (e, data, status, xhr) =>
      @prepend_new_post(data)
    )

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
    _.each(posts_data, (post) =>
      posts += @build_post post
    )
    $("#posts-container").append(posts)

  prepend_new_post: (data) ->
    template = @build_post data
    $("#new_post").after(template)

  build_post: (post) ->
    tmpl = JST["post"]
    tmpl(id: post.id, name: post.user.name, avatar_url: post.user.avatar_url, text: post.text, video_type: post.video_type, video_id: post.video_id)


