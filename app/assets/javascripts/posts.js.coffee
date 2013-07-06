$ ->
  $("#posts-container").each( ->
    new CFB.Posts()
  )

CFB.Posts = class Posts

  constructor: ->
    @$container = $("#posts-container")
    @num_pages = @$container.attr("data-pages")
    @next_page = 1
    @$more_link = $("a#more-posts")
    @$create_submit = $("input[type=submit]")
    @init_events()
    @fetch_posts()
    
  init_events: ->
    if CFB.touch
      @$more_link.bind("touchstart", => @fetch_posts())
    else
      @$more_link.click => @fetch_posts()

    $("#new_post").on("ajax:success", (e, data, status, xhr) =>
      @clear_post_form()
      @prepend_new_post(data)
    )

  fetch_posts: ->
    $.ajax
      url: "/newsfeed/posts/page/#{@next_page}.json",
      type: 'get',
      datatype: 'json',
      success: (data, textstatus, xhr) =>
        @add_posts(data)
        if @next_page < @num_pages
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
    @$container.append(posts)
    CFB.Comments.init()

  clear_post_form: ->
    $("#post_text").val("")
    $("#post_video_url").val("")
    $("#post_image").parent().html($("#post_image").parent().html())

  prepend_new_post: (data) ->
    template = @build_post data.post
    $("#posts-container").prepend(template)

  build_post: (post) ->
    tmpl = JST["post"]
    if post.post_image_urls
      tmpl(id: post.id, user_id: post.user.id, name: post.user.name, avatar_url: post.user.avatar_url, text: post.text, comments: post.comments, img_med: post.post_image_urls.med, img_med_2x: post.post_image_urls.med_2x, img_sm: post.post_image_urls.sm, img_sm_2x: post.post_image_urls.sm_2x, video_type: post.video_type, video_id: post.video_id)
    else
      tmpl(id: post.id, user_id: post.user.id, name: post.user.name, avatar_url: post.user.avatar_url, text: post.text, comments: post.comments, video_type: post.video_type, video_id: post.video_id)
