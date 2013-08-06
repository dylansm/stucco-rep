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
    @$hidden_file_input = $("#post_post_image")
    @$upload_link = $("#upload-link")
    @$video_url_link = $("#video-url")
    @$more_link = $("a#more-posts")
    @$create_submit = $("input[type=submit]")
    @init_events()
    @fetch_posts()
    
  init_events: ->
    if CFB.touch
      @$more_link.bind("touchstart", () => @fetch_posts())
      @$upload_link.bind("touchstart", (e) => @open_file_sheet(e))
      $("#new_post button.choose-photo").bind("touchstart", (e) => @open_file_sheet(e))
      @$video_url_link.bind("touchstart", (e) => @enter_video_url(e))
      $('a.mobile-new-post-toggle').on("touchstart", (e) =>
        @open_new_post_mobile(e)
      )
      $('.new-post-cancel').on("touchstart", (e) =>
        @close_new_post_mobile(e)
      )
    else
      @$more_link.click => @fetch_posts()
      @$upload_link.click (e) => @open_file_sheet(e)
      $("#new_post button.choose-photo").click (e) => @open_file_sheet(e)
      @$video_url_link.click (e) => @enter_video_url(e)
      $('a.mobile-new-post-toggle').click (e) =>
        @open_new_post_mobile(e)
      $('.new-post-cancel').click (e) =>
        @close_new_post_mobile(e)

    @$hidden_file_input.on("change", =>
      @on_file_selected()
    )

    $("#new_post").on("ajax:success", (e, data, status, xhr) =>
      @clear_post_form()
      @prepend_new_post(data)
    )

  open_new_post_mobile: (e) ->
    e.preventDefault()
    $('.new-post').addClass('mobile-new-post-active')

  close_new_post_mobile: (e) ->
    e.preventDefault()
    $(".secondary-inputs.choose-photo").removeClass("choose-photo")
    $(".secondary-inputs.choose-video").removeClass("choose-video")
    $("a.video-upload-link.selected").removeClass("selected")
    $("a.photo-upload-link.selected").removeClass("selected")
    $('.new-post').removeClass('mobile-new-post-active')

  init_edit_events: (id=null) ->
    _this = @
    $(".post-video").fitVids() unless $(document.documentElement).hasClass("ie9");
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
        $editor_wrap.unbind("touchstart").bind("touchstart", (e) ->
          e.preventDefault()
          $(this).parent().toggleClass('non-modal')
          CFB.Utils.non_modal_ui()
        )
        $edit.unbind("touchstart").bind("touchstart", (e) ->
          _this.edit_post(e, post_id))
        $delete.unbind("touchstart").bind("touchstart", (e) ->
          _this.delete_post(e, post_id))
      else
        $editor_wrap.off("click").on("click", ->
          $(this).parent().toggleClass('non-modal')
          CFB.Utils.non_modal_ui()
        )

        $edit.off("click").on("click", (e) ->
          $editor_wrap.parent().removeClass("non-modal")
          _this.edit_post(e, post_id)
        )
        $delete.off("click").on("click", (e) ->
          $editor_wrap.parent().removeClass("non-modal")
          _this.delete_post(e, post_id)
        )

  fetch_posts: ->
    @$more_link.addClass("waiting")
    $.ajax
      url: "/newsfeed/posts/page/#{@next_page}.json",
      type: 'get',
      datatype: 'json',
      success: (data, textstatus, xhr) =>
        @$more_link.removeClass("waiting")
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
    _.each(posts_data, (post) =>
      post_html = @build_post post
      @$container.append(post_html)
    )
    @init_edit_events()
    @comments ||= new CFB.Comments
    @comments.init(posts_data)
    @likes ||= new CFB.Likes
    @likes.init(posts_data)
    @ratings ||= new CFB.Ratings
    @ratings.init(posts_data)

  clear_post_form: ->
    $("#post_text").val("")
    $("#post_video_url").val("")
    $("#post_image").parent().html($("#post_image").parent().html())

  prepend_new_post: (data) ->
    template = @build_post data.post
    $("#posts-container").prepend(template)
    @init_edit_events(data.post.id)
    @comments.init_latest_post()

  build_post: (post) ->
    post_data = @gather_post_data(post)
    tmpl = JST["post"]
    post = tmpl(post_data)
    post

  gather_post_data: (post) ->
    user_id = parseInt $("body").attr("data-user-id"), 10
    admin_viewer = !!$("body").attr("data-admin")
    if post.rating
      rating = post.rating.rating
    else
      rating = "0"
    created_at = CFB.Utils.format_publish_date(post.created_at)
    post_data =
      id: post.id
      created_at: created_at.full
      created_at_short: created_at.short
      user_id: post.user.id
      name: post.user.name
      school_name: post.user.school.name if post.user.school
      avatar_url_med: post.user.avatar_url_med
      avatar_url_med2x: post.user.avatar_url_med2x
      text: CFB.Utils.html(post.text)
      rating: rating
      comments: post.comments
      video_type: post.video_type
      video_url: post.video_url if post.video_url
      video_id: post.video_id

    if post.post_image_urls
      img_data =
        img_med: post.post_image_urls.med
        img_med_2x: post.post_image_urls.med_2x
        img_sm: post.post_image_urls.sm
        img_sm_2x: post.post_image_urls.sm_2x

      _.extend(post_data, img_data)

    if post.user.id == user_id
      _.extend(post_data, { post_author: true })
    else if admin_viewer
      _.extend(post_data, { admin_viewer: true })

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
    text = ''
    $("p", $text_wrap).each ->
      text += $(this).text() + "\n\n"
    video_url = $post.attr("data-video-url")
    @init_cancel_update($post, $post_content)
    @init_delete_image($post)

    edit_tmpl = JST["edit_post"](text: text, video_url: video_url)
    $text_wrap.after(edit_tmpl)
    $edit_textarea = $('#edit-post-form textarea:first')
    $edit_textarea.autosize({append: "\n"})  

  init_cancel_update: ($post, $post_content) ->
    cancel_link = document.getElementById("cancel-edit")
    if cancel_link
      return if $.contains($post[0], cancel_link)
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
    else
      $post = $(".post-content.editing").parent()
    $("#update-buttons").detach()
    $("#edit-post-form").detach()
    $post_content = $(".post-content", $post)
    $post_content.removeClass("editing")
    $(".edit-mode", $post).each ->
      $(this).detach()
    $(".post-image", $post).show()

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
    $post = $post.parent()
    $post.fadeOut 'slow', ->
      $post.detach()

  update_post: (e) ->
    e.preventDefault()
    $post = $(e.target).closest("div.post")
    id = parseInt $post.attr("data-id"), 10
    text = $("textarea:first", ".post[data-id='#{id}']").val()
    remove_image = null
    if $(".post-image", $post).css("display") == "none"
      remove_image = 1
    video_url = null
    if document.getElementById("edit-video-url")
      video_url = document.getElementById("edit-video-url").value;
    post_json = { utf8: "✓", _method: 'patch', post: { text: text, remove_image: remove_image, video_url: video_url } }
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
    $post.parent().replaceWith(template)
    @init_edit_events(id)

  # custom file upload
  open_file_sheet: (e) ->
    e.preventDefault()
    e.stopPropagation()
    if $("#post_video_url").val().length > 0
      unless confirm("You have already entered a video URL.\nAre you sure you want to upload an image instead?")
        return
    $("#post_post_image").click().focus()

  on_file_selected: ->
    filename = @$hidden_file_input.val().split('\\').pop()
    $("#post_video_url").val("")
    $("#file-name").val(filename)
    $("#new_post .secondary-inputs").removeClass("choose-video")
    $("#new_post .secondary-inputs").addClass("choose-photo")
    $("#new_post a.video-upload-link").removeClass("selected")
    $("#new_post a.photo-upload-link").addClass("selected")

  enter_video_url: (e) ->
    e.preventDefault()
    e.stopPropagation()
    if $("#post_post_image").val().length > 0
      unless confirm("You have already selected an image to upload.\nAre you sure you want to enter a video URL instead?")
        return
      $("#post_post_image").val("")
    $("#new_post .secondary-inputs").removeClass("choose-photo")
    $("#new_post .secondary-inputs").addClass("choose-video")
    $("#new_post a.photo-upload-link").removeClass("selected")
    $("#new_post a.video-upload-link").addClass("selected")
        
  init_delete_image: ($post) ->
    if CFB.touch
      $(".remove-image", $post).bind("touchstart", (e) => @prep_image_for_delete(e, $post))
    else
      $(".remove-image", $post).click (e) => @prep_image_for_delete(e, $post)

  prep_image_for_delete: (e, $post) ->
    e.preventDefault()
    $(".post-image", $post).fadeOut("slow")
