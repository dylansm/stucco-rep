CFB.Comments = class Comments

  constructor: (posts_data)->
    @post_id = null
    @init_events()
    @init_comment_link_text(posts_data)
  
  init_events: ->
    _this = @
    $("a.comment-link").each ->
      post_id = $(this).closest(".post").attr("data-id")
      if CFB.touch
        $(this).on("touchstart", (e) -> _this.swap_comment_link(e, this, post_id))
      else
        $(this).on("click", (e) -> _this.swap_comment_link(e, this, post_id))

  init_comment_link_text: (posts_data) ->
    _.each(posts_data, (post_data) =>
      @update_comment_link_text(post_data)
    )

  update_comment_link_text: (post_data) ->
    num_comments = post_data.comments.length
    $post = $(".post[data-id='#{post_data.id}']")
    $link = $(".comment-link", $post)
    $link_text = $("span.link-text", $link)
    if num_comments > 0
      user_ids = _.pluck(post_data.comments, 'user_id')
      if _.contains(user_ids, @user_id)
        $link.addClass("commented")
      else
        $link.removeClass("commented")
      $link_text.html("Comment (#{num_comments})")
    else
      $link.removeClass("commented")
      $link_text.html("Comment")

  
  init_latest_post: ->
    link = $(".comment-link")[0]
    @init_comment_link(link)
        
  swap_comment_link: (e, link, post_id) ->
    e.preventDefault()
    if $(link).hasClass("open")
      return
    @post_id = post_id
    tmpl = JST["comment_form"]()
    $(link).addClass("open")
    $post = $(link).closest(".post")
    if $(".post-comments", $post).length > 0
      $comments = $(".post-comments", $post)
      $comments.after(tmpl)
    else
      $comments-wrap = $(".post-comments-wrap", $post)
      $comments-wrap.append(tmpl)
    
    $comment_textarea = $(".comment-form textarea", $post)
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
    $comment_form = $(".comment-form", $post)
    $comment_textarea = $("textarea:first", $comment_form)
    if $comment_textarea.val() == ""
      return
    comment_json = { utf8: "✓", comment: { text: $comment_textarea.val() }}
    $.ajax
      url: "/newsfeed/posts/#{@post_id}/comments",
      type: 'post',
      datatype: 'json',
      data: comment_json,
      success: (data, textstatus, xhr) =>
        @remove_form(e, $post)
        @update_comment_link_text(data.post)
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
