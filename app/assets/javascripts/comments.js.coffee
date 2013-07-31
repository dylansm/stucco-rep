CFB.Comments = class Comments

  constructor: (posts_data)->
    @init_events()
    @init_comment_link_text(posts_data)
    @add_comment_forms_below_existing()
  
  init_events: ->
    _this = @
    $("a.comment-link").each ->
      #post_id = $(this).closest(".post").attr("data-id")
      $post = $(this).closest(".post")
      if CFB.touch
        $(this).on("touchstart", (e) -> _this.add_comment_form(e, $post))
      else
        $(this).on("click", (e) -> _this.add_comment_form(e, $post))

  init_comment_link_text: (posts_data) ->
    _.each(posts_data, (post_data, index) =>
      $post = $($(".post")[index])
      $link = $(".comment-link", $post)
      CFB.Utils.format_link(post_data, $link, @user_id)
    )
  
  add_comment_forms_below_existing: ->
    _this = @
    $(".post-comments").each ->
      $post = $(this).closest(".post")
      _this.add_comment_form(null, $post)

  #TODO
  init_latest_post: ->
    link = $(".comment-link")[0]
    @init_comment_link(link)

  add_comment_form: (e, $post) ->
    if e
      e.preventDefault()
    if $(".comment-form", $post).length > 0
      $(".comment-form textarea", $post).focus()
      return

    tmpl = JST["comment_form"]()
    if $(".post-comments", $post).length > 0
      $comments = $(".post-comments", $post)
      $comments.after(tmpl)
    else
      $comments-wrap = $(".post-comments-wrap", $post)
      $comments-wrap.append(tmpl)
    
    $comment_textarea = $(".comment-form textarea", $post)
    if e
      $comment_textarea.focus()
    $comment_textarea.autosize({append: "\n"})  

    @init_delayed_events($post)

  init_delayed_events: ($post) ->
    _this = @
    if CFB.touch
      $("button.submit", @$comment_form).on("touchstart", (e) -> _this.submit_comment(e, $post))
      $("button.cancel", @$comment_form).on("touchstart", (e) -> _this.remove_form(e, $post))
    else
      $("button.submit", @$comment_form).on("click", (e) -> _this.submit_comment(e, $post))
      $("button.cancel", @$comment_form).on("click", (e) -> _this.remove_form(e, $post))

  remove_form: (e, $post) ->
    e.preventDefault()
    $form = $(".comment-form", $post)
    $form.detach()
    $(".comment-link.open", $post).removeClass("open")

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
    comment_tmpl = JST["comment"](id: comment.user.id, avatar_url: comment.user.avatar_url, avatar_url_sm: comment.user.avatar_url_sm, name: comment.user.name, text: CFB.Utils.html(comment.text))
    $comments_container = $(".post-comments", $post)
    if $comments_container.length > 0
      $comments_container.append(comment_tmpl)
    else
      $comments_container = $('<div class="post-comments"></div>')
      $(".post-comments-wrap", $post).append($comments_container)
      $comments_container.append(comment_tmpl)

CFB.Comments.init = (posts_data) ->
  new CFB.Comments(posts_data)
