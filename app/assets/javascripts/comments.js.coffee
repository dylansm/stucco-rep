CFB.Comments = class Comments

  init: (posts_data) ->
    @posts_data = posts_data
    @init_events()
    @init_comment_link_text()
    @add_forms_below_comments()
  
  init_events: ->
    _this = @
    $("a.comment-link").each ->
      $post = $(this).closest(".post")
      if CFB.touch
        $(this).on("touchstart", (e) -> _this.add_comment_form(e, $post))
      else
        $(this).on("click", (e) -> _this.add_comment_form(e, $post))

  init_comment_link_text: ->
    _.each(@posts_data, (post_data) =>
      $post = $($(".post[data-id='#{post_data.id}']"))
      $link = $(".comment-link", $post)
      CFB.Utils.format_link(post_data, $link, @user_id)
    )
  
  add_forms_below_comments: ->
    _this = @
    $(".post-comments").each ->
      $post = $(this).closest(".post")
      _this.add_comment_form(null, $post)

  add_comment_form: (e, $post) ->
    if e
      e.preventDefault()

      if $(".comment-form", $post).length > 0
        $(".comment-form textarea", $post).focus()
        return

    tmpl = JST["comment_form"]()
    if $(".post-comments", $post).length > 0
      # under existing comments
      $comments = $(".post-comments", $post)

      unless $(".comment-form", $post).length > 0
        $comments.after(tmpl)
    else
      $comments-wrap = $(".post-comments-wrap", $post)
      $comments-wrap.append(tmpl)
    
    $comment_textarea = $(".comment-form textarea", $post)

    if e
      window.setTimeout ->
        $comment_textarea.focus()
      , 10
    $comment_textarea.autosize({append: "\n"})  

    @init_delayed_events($post)

  init_delayed_events: ($post) ->
    _this = @
    $textarea = $(".comment-form textarea", $post)
    $textarea.on("focus", -> $(".ui-wrap", $post).addClass("vis"))
    if CFB.touch
      $(document.documentElement).unbind("touchstart").bind "touchstart", (e) =>
        @hide_comment_buttons(e)
      $("button.submit", @$comment_form).off("touchstart").on("touchstart", (e) -> _this.submit_comment(e, $post))
      $("button.cancel", @$comment_form).off("touchstart").on("touchstart", (e) -> _this.remove_form(e, $post))
    else
      $(document.documentElement).unbind("click").bind("click", (e) =>
        @hide_comment_buttons(e)
      )
      $("button.submit", @$comment_form).off("click").on("click", (e) -> _this.submit_comment(e, $post))
      $("button.cancel", @$comment_form).off("click").on("click", (e) -> _this.remove_form(e, $post))

  hide_comment_buttons: (e) ->
    # comment link
    if $(e.target).hasClass("link-text")
      e.target = e.target.parentNode
    if $(e.target).hasClass("comment-link")
      $comment_link = true

    $closest_post = []
    if $(e.target).get(0).tagName == ("TEXTAREA" || "BUTTON") ||
      $comment_link
        $closest_post = $(e.target).closest(".post")
    if $closest_post.length > 0
      $(".post").each ->
        unless this == $closest_post[0]
          $(".comment-form .ui-wrap", this).removeClass("vis")
    else
      $(".comment-form .ui-wrap").removeClass("vis")


  remove_form: (e, $post) ->
    e.preventDefault()
    $form = $(".comment-form", $post)
    if $(".post-comments", $post).length > 0
      $(".comment-form textarea", $post).val("")
      $(".ui-wrap", $post).removeClass("vis")
    else
      $form.detach()

  submit_comment: (e, $post) ->
    $link = $(".comment-link", $post)
    $comment_form = $(".comment-form", $post)
    $comment_textarea = $("textarea:first", $comment_form)
    if $comment_textarea.val() == ""
      return
    post_id = $link.closest(".post").attr("data-id")
    comment_json = { utf8: "✓", comment: { text: $comment_textarea.val() }}
    $.ajax
      url: "/newsfeed/posts/#{post_id}/comments",
      type: 'post',
      datatype: 'json',
      data: comment_json,
      success: (data, textstatus, xhr) =>
        @remove_form(e, $post)
        CFB.Utils.format_link(data.post, $link, @user_id)
        @add_comment(data.post, $post)
      error: (response) ->
        console.log response

  add_comment: (post_data, $post) =>
    comment = _.last(post_data.comments)
    comment_tmpl = JST["comment"](id: comment.user.id, avatar_url_lg: comment.user.avatar_url_lg, avatar_url_sm: comment.user.avatar_url_sm, name: comment.user.name, text: CFB.Utils.html(comment.text))
    $comments_container = $(".post-comments", $post)
    if $comments_container.length > 0
      $comments_container.append(comment_tmpl)
    else
      $comments_container = $('<div class="post-comments"></div>')
      $(".post-comments-wrap", $post).append($comments_container)
      $comments_container.append(comment_tmpl)
