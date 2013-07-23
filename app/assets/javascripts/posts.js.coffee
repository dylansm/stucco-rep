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
    $(".post-video").fitVids();
    if id
      $post_admin = $("div.post[data-id='#{id}'] div.post-edit")
    else
      $post_admin = $("div.post div.post-edit")

    $post_admin.each ->
      if id
        post_id = id
      else
        post_id = $(this).parent().attr("data-id")
      $editor_wrap = $("a.edit", this)
      $edit = $("li:first a", this)
      $delete = $("li:last a", this)

      if CFB.touch
        $editor_wrap.bind("touchstart", (e) ->
          e.preventDefault()
          $(this).parent().toggleClass('non-modal')
          CFB.Utils.non_modal_ui()
        )
        $edit.bind("touchstart", (e) ->
          _this.edit_post(e, post_id))
        $delete.bind("touchstart", (e) ->
          _this.delete_post(e, post_id))
      else
        $editor_wrap.click ->
          $(this).parent().toggleClass('non-modal')
          CFB.Utils.non_modal_ui()

        $edit.click (e) ->
          $editor_wrap.parent().removeClass("non-modal")
          _this.edit_post(e, post_id)
        $delete.click (e) ->
          $editor_wrap.parent().removeClass("non-modal")
          _this.delete_post(e, post_id)

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
    #console.log posts_data
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
      school_name: post.user.school.name if post.user.school
      avatar_url: post.user.avatar_url
      text: CFB.Utils.html(post.text)
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
      if @edit_id == id
        return
      @cancel_edit_post()
    @edit_id = id
    e.preventDefault()
    $post = $(e.target).closest("div.post")
    $post_content = $(".post-content", $post)
    $post_content.addClass("editing")
    $text_wrap = $("div:first", $post_content)
    text = $("p", $text_wrap).text()
    #$new_textarea = $("#post_text").clone()
    #$new_textarea.addClass("edit-mode")
    #$new_textarea.text($("p", $text_wrap).text())

    #window.setTimeout ->
      #$new_textarea.height($new_textarea[0].scrollHeight)
    #, 1

    @init_cancel_update($post_content)

    #$text_wrap.after($new_textarea)

    edit_tmpl = JST["edit_post"](text: text)
    $text_wrap.after(edit_tmpl)


    #$text_wrap.after($new_textarea)

    #new_video_url_field = document.createElement("input")
    #new_video_url_field.setAttribute("type", "text")
    #new_video_url_field.setAttribute("id", "edit-url")
    #new_vid_label = document.createElement("label")
    #new_vid_label.text("Video URL")
    #$new_textarea.after($(new_vid_label))
    #$new_vid_label.append($(new_video_url_field))

  init_cancel_update: ($post_content) ->
    $cancel_link = $("#cancel-edit")
    if $cancel_link.length > 0
      return if $post.contains($cancel_link)
    else
      edit_tmpl = JST["edit_post_ui"]()
      $post_content.append(edit_tmpl)

    $cancel_link = $("button#cancel-edit", $post_content)
    $update_link = $("button#edit-submit", $post_content)
    if CFB.touch
      $cancel_link.bind("touchstart", (e) => @cancel_edit_post(e))
      $update_link.bind("touchstart", (e) => @update_post(e))
    else
      $cancel_link.click (e) => @cancel_edit_post(e)
      $update_link.click (e) => @update_post(e)
  
  cancel_edit_post: (e=null) ->
    @edit_id = null
    if e
      e.preventDefault()
      $post = $(e.target).closest("div.post")
      $cancel_el = $(e.target)
    else
      $post = $(".post-content.editing").parent()
      $cancel_el = $("#cancel-edit")
    #$cancel_el.parent().detach()
    $("#edit-post-form").detach()
    $post_content = $(".post-content", $post)
    $post_content.removeClass("editing")
    $(".edit-mode", $post).each ->
      $(this).detach()

  delete_post: (e, id) ->
    e.preventDefault()
    $post = $(e.target).closest("div.post")
    delete_confirm = "Are you sure you want to delete this post?"
    if confirm delete_confirm
      $.ajax
        url: "/newsfeed/posts/#{id}",
        type: 'post',
        dataType: 'json',
        data: {"_method": "delete"},
        success: (data, textStatus, xhr) =>
          @remove_post($post)
        error: (response) ->
          console.log response

  remove_post: ($post) ->
    $post.fadeOut 'slow', ->
      $post.detach()

  update_post: (e) ->
    e.preventDefault()
    $post = $(e.target).closest("div.post")
    id = parseInt $post.attr("data-id"), 10
    text = $("textarea:first", ".post[data-id='#{id}']").val()
    post_json = { utf8: "✓", _method: 'patch', post: { text: text } }
    $.ajax
      url: "newsfeed/posts/#{id}",
      type: 'post',
      datatype: 'json',
      data: post_json,
      success: (data, textstatus, xhr) =>
        @render_updated_post($post, id, data)
      error: (response) ->
        console.log response
      
  render_updated_post: ($post, id, data) ->
    @cancel_edit_post()
    template = @build_post data.post
    $post.replaceWith(template)
    @init_edit_events(id)
