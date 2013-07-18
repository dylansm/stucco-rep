$ ->
  $("#posts-container").each( ->
    new CFB.Posts()
  )

CFB.Posts = class Posts

  constructor: ->
    @$container = $("#posts-container")
    @num_pages = @$container.attr("data-pages")
    @next_page = 1
    @edit_id = null
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

  init_edit_events: (id=null) ->
    _this = @
    if id
      $post_admin = $("div.post[data-id=['#{id}']")
    else
      $post_admin = $("div.post ul.post-admin")

    $post_admin.each ->
      if id
        post_id = id
      else
        post_id = $(this).parent().attr("data-id")
      $edit = $("li:first a", this)
      $delete = $("li:last a", this)

      if CFB.touch
        $edit.bind("touchstart", (e) -> _this.edit_post(e, post_id))
        $delete.bind("touchstart", (e) -> _this.delete_post(e, post_id))
      else
        $edit.click (e) -> _this.edit_post(e, post_id)
        $delete.click (e) -> _this.delete_post(e, post_id)

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
      post_html = @build_post post
      @$container.append(post_html)
    )
    @init_edit_events()
    @comments = CFB.Comments.init()
    @likes = CFB.Likes.init(posts_data)

  clear_post_form: ->
    $("#post_text").val("")
    $("#post_video_url").val("")
    $("#post_image").parent().html($("#post_image").parent().html())

  prepend_new_post: (data) ->
    template = @build_post data.post
    $("#posts-container").prepend(template)
    @comments.init_latest_post()

  build_post: (post) ->
    post_data = @gather_post_data(post)
    tmpl = JST["post"]
    post = tmpl(post_data)
    post

  gather_post_data: (post) ->
    user_id = parseInt $("body").attr("data-user-id"), 10
    post_data =
      id: post.id
      user_id: post.user.id
      name: post.user.name
      avatar_url: post.user.avatar_url
      text: @html_safe(post.text)
      comments: post.comments
      video_type: post.video_type
      video_id: post.video_id

    if post.post_image_urls
      img_data =
        img_med: post.post_image_urls.med
        img_med_2x: post.post_image_urls.med_2x
        img_sm: post.post_image_urls.sm
        img_sm_2x: post.post_image_urls.sm_2x

      _.extend(post_data, img_data)

    if post.user.id == user_id
      author = true
      _.extend(post_data, { post_author: true })

    post_data

  edit_post: (e, id) ->
    if @edit_id
      return
    @edit_id = id
    e.preventDefault()
    $post = $(e.target).closest("div.post")
    $post_content = $(".post-content", $post)
    $post_content.addClass("editing")
    $text_wrap = $("div:first", $post_content)

    #TODO remove this
    $text_wrap.hide()

    $new_textarea = $("#post_text").clone()
    $new_textarea.addClass("edit-mode")
    $new_textarea.text($text_wrap.text())
    @init_edit_cancel($post)
    $text_wrap.after($new_textarea)

  init_edit_cancel: ($post) ->
    $cancel_link = $("#cancel-edit-link")
    if $cancel_link.length > 0
      return if $post.contains($cancel_link)
    else
      cancel_tmpl = JST["cancel_edit_post"]()
      $post.prepend(cancel_tmpl)

    $cancel_link = $("a#cancel-edit-link", $post)
    if CFB.touch
      $cancel_link.bind("touchstart", (e) => @cancel_edit_post(e))
    else
      $cancel_link.click (e) => @cancel_edit_post(e)

  cancel_edit_post: (e) ->
    e.preventDefault()
    @edit_id = null
    $post = $(e.target).closest("div.post")
    $post_content = $(".post-content", $post)
    $post_content.removeClass("editing")
    $(e.target).detach()
    $(".edit-mode", $post).each ->
      $(this).detach()

    #TODO remove this
    $(":hidden", $post).show()

  delete_post: (e, id) ->
    e.preventDefault()
    $post = $(e.target).closest("div.post")


  html_safe: (text) ->
    text = text.replace(/\n/, "<br/></br>")
    url_re = /(http[s]?:\/\/(www\.)?|ftp:\/\/(www\.)?|www\.){1}([0-9A-Za-z-\.@:%_\+~#=]+)+((\.[a-zA-Z]{2,3})+)(\/(.)*)?(\?(.)*)?/g
    url_match = text.match(url_re)
    _.each(url_match, (url) ->
      protocol_re = /^http:\/\//
      if protocol_re.test(url)
        full_url = url
      else
        full_url = "http://#{url}"

      anchor_re = new RegExp("[^/>']#{url}", 'g')

      text = text.replace(anchor_re, " <a href='#{full_url}' target='_blank'>#{url}</a>")
      console.log text
    )

    text
