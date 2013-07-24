CFB.Comments = class Comments

  constructor: ->
    @post_id = null
    @init_events()
  
  init_events: ->
    _this = @
    $("a.comment-link").each ->
      _this.init_comment_link(this)
  
  init_latest_post: ->
    link = $(".comment-link")[0]
    @init_comment_link(link)

  init_comment_link: (link) ->
    _this = @
    post_id = $(link).closest(".post").attr("data-id")
    if CFB.touch
      $(link).on("touchstart", (e) -> _this.swap_comment_link(e, this, post_id))
    else
      $(link).on("click", (e) -> _this.swap_comment_link(e, this, post_id))
        
  swap_comment_link: (e, link, post_id) ->
    e.preventDefault()
    if $(link).hasClass("open")
      return
    @post_id = post_id
    tmpl = JST["comment_form"]()
    $(link).addClass("open")
    $(link).append(tmpl)
    $comment_textarea = $("#comment-text", link)
    $comment_textarea.focus()
    $comment_textarea.autosize({append: "\n"})  

    @init_delayed_events()

  init_delayed_events: ->
    _this = @
    if CFB.touch
      $("button.submit", @$comment_form).on("touchstart", -> _this.submit_comment(this.parentNode))
      $("button.cancel", @$comment_form).on("touchstart", -> _this.remove_form())
    else
      $("button.submit", @$comment_form).on("click", -> _this.submit_comment(this.parentNode))
      $("button.cancel", @$comment_form).on("click", -> _this.remove_form())

  remove_form: ->
    #$("#comment-form").closest(".comment-link.open").removeClass("open")
    $test = $("#comment-form").closest(".comment-link.open")
    $("#comment-form").detach()
    $test.removeClass("open")

    #$(comment_form.parentNode).removeClass("open")
    #$(comment_form).remove()

  submit_comment: (comment_form) ->
    if $("#comment-text", comment_form).val() == ""
      return
    comment_json = { utf8: "✓", comment: { text: $("#comment-text").val() }}
    $.ajax
      url: "/newsfeed/posts/#{@post_id}/comments",
      type: 'post',
      datatype: 'json',
      data: comment_json,
      success: (data, textstatus, xhr) =>
        @remove_form(comment_form)
        @add_comment(data)
      error: (response) ->
        console.log response

  add_comment: (data) =>
    comment_tmpl = JST["comment"](id: data.comment.user.id, name: data.comment.user.name, text: CFB.Utils.html(data.comment.text))
    $post_container = $(".post[data-id='#{@post_id}']")
    $comments_container = $(".comments-container", $post_container)
    $comments_container.append(comment_tmpl)

CFB.Comments.init = ->
  new CFB.Comments()
